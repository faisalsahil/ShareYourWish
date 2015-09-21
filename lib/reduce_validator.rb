# http://stackoverflow.com/questions/2569401/rails-validation-error-messages-displaying-only-one-error-message-per-field
class ReduceValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return until record.errors.has_key?(attribute)
    record.errors[attribute].slice!(-1) until record.errors[attribute].size <= 1
  end
end