class CreditCardNumberValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)     
    object.errors.add(attribute, :credit_card_number, options) unless passes_luhn?(value)
  end

  def passes_luhn?(number)
    odd = true
    number.to_s.gsub(/\D/,'').reverse.split('').map(&:to_i).collect { |d|
      d *= 2 if odd = !odd
      d > 9 ? d - 9 : d
    }.sum % 10 == 0
  end

end
