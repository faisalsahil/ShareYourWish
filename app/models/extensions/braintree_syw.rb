module Extensions
  module BraintreeSyw
    extend ActiveSupport::Concern

    # you can include other things here
    included do
      attr_accessor :credit_cards
      attr_accessible :braintree_customer_id
    end

    # include class methods here
    # like User.most_popular
    module ClassMethods
    # def most_popular(limit=10)
    # order_by(:points.desc).limit(limit).all
    # end
    end
    
    
    CODES = {
      '1000' => 'Approved',
      '1001' => 'Approved, check customer ID',
      '1002' => 'Processed - This code will be assigned to all credits and voice authorizations.',
      
      '2000' => 'Do Not Honor',
      '2001' => 'Insufficient Funds',
      '2002' => 'Limit Exceeded',
      '2003' => 'Cardholder\'s Activity Limit Exceeded',
      '2004' => 'Expired Card',
      '2005' => 'Invalid Credit Card Number',
      '2006' => 'Invalid Expiration Date',
      '2007' => 'No Account',
      '2008' => 'Card Account Length Error',
      '2009' => 'No Such Issuer',
      '2010' => 'Card Issuer Declined CVV',
      '2011' => 'Voice Authorization Required',
      '2012' => 'Processor Declined - Possible Lost Card',
      '2013' => 'Processor Declined - Possible Stolen Card',
      '2014' => 'Processor Declined - Fraud Suspected',
      '2015' => 'Transaction Not Allowed',
      '2016' => 'Duplicate Transaction',
      '2017' => 'Cardholder Stopped Billing',
      '2018' => 'Cardholder Stopped All Billing',
      '2019' => 'Invalid Transaction',
      '2020' => 'Violation',
      '2021' => 'Security Violation',
      '2022' => 'Declined - Updated Cardholder Available',
      '2023' => 'Processor Does Not Support This Feature',
      '2024' => 'Card Type Not Enabled',
      '2025' => 'Set Up Error - Merchant',
      '2026' => 'Invalid Merchant ID',
      '2027' => 'Set Up Error - Amount',
      '2028' => 'Set Up Error - Hierarchy',
      '2029' => 'Set Up Error - Card',
      '2030' => 'Set Up Error - Terminal',
      '2031' => 'Encryption Error',
      '2032' => 'Surcharge Not Permitted',
      '2033' => 'Inconsistent Data',
      '2034' => 'No Action Taken',
      '2035' => 'Partial Approval For Amount In Group III Version',
      '2036' => 'Authorization could not be found to reverse',
      '2037' => 'Already Reversed',
      '2038' => 'Processor Declined',
      '2039' => 'Invalid Authorization Code',
      '2040' => 'Invalid Store',
      '2041' => 'Declined - Call For Approval',
      '2043' => 'Error - Do Not Retry, Call Issuer',
      '2044' => 'Declined - Call Issuer',
      '2045' => 'Invalid Merchant Number',
      '2046' => 'Declined',
      '2047' => 'Call Issuer. Pick Up Card.',
      '2048' => 'Invalid Amount',
      '2049' => 'Invalid SKU Number',
      '2050' => 'Invalid Credit Plan',
      '2051' => 'Credit Card Number does not match method of payment',
      '2052' => 'Invalid Level III Purchase',
      '2053' => 'Card reported as lost or stolen',
      '2054' => 'Reversal amount does not match authorization amount',
      '2055' => 'Invalid Transaction Division Number',
      '2056' => 'Transaction amount exceeds the transaction division limit',
      '2057' => 'Issuer or Cardholder has put a restriction on the card',
      '2058' => 'Merchant not MasterCard SecureCode enabled.',
      '2059' => 'Address Verification Failed',
      '2060' => 'Address Verification and Card Security Code Failed',
      '2061' => 'Invalid Transaction Data',
      '2062' => 'Invalid Tax Amount',
    }

    # include Instance methods
    def create_braintree_customer!
      result = Braintree::Customer.create(
      :email => self.email
      )
      self.update_attribute(:braintree_customer_id, result.customer.id) if result.success?
      result.success?
    end

    def get_braintree_customer
      return nil unless self.braintree_customer_id
      Braintree::Customer.find(self.braintree_customer_id)
    rescue Braintree::NotFoundError
      self.create_braintree_customer!
      Braintree::Customer.find(self.braintree_customer_id)
    end

    def delete_braintree_customer!
      return false unless self.braintree_customer_id
      result = Braintree::Customer.delete(self.braintree_customer_id)
      self.update_attribute(:braintree_customer_id, nil)  if result.success?
      result.success?
    end

    def create_braintree_credit_card! options, default = true
      return false unless self.braintree_customer_id

      result = Braintree::CreditCard.create(
      :customer_id => self.braintree_customer_id,
      :number => options[:number],
      :expiration_month => options[:expiration_month],
      :expiration_year => options[:expiration_year],
      :cardholder_name => self.full_name,
      :options => {
        :make_default => default
      }
      )
      result.success?
    end

    def create_test_braintree_credit_card!
      return false unless self.braintree_customer_id
      result = Braintree::CreditCard.create(
        :customer_id => self.braintree_customer_id,
        :number => '4111111111111111',
        :expiration_month => '12',
        :expiration_year => '2015',
        :cardholder_name => self.full_name,
        :options => {
          :make_default => true
        }
        )
      result.success?
    end

    def delete_braintree_credit_card! token
      Braintree::CreditCard.delete(token)
    end

    def delete_braintree_all_credit_cards!
      return false unless self.braintree_customer_id

      self.get_braintree_customer.credit_cards.each do |card|
        Braintree::CreditCard.delete(card.token)
      end
    end

    def has_payment_info?
      !!braintree_customer_id
    end

    def with_braintree_data!
      return self unless has_payment_info?
      braintree_data = Braintree::Customer.find(braintree_customer_id)
      self.credit_cards = braintree_data.credit_cards
      self
    end

    def default_credit_card
      return unless has_payment_info?
      self.get_braintree_customer.credit_cards.find { |cc| cc.default? }
    end

    def braintree_transaction_create! payment
      return false unless payment.is_a? Payment
      
      self.create_braintree_customer! if self.get_braintree_customer.nil?
      self.create_braintree_credit_card!(payment.credit_card_hash) if self.default_credit_card.nil?
      braintree_customer = self.get_braintree_customer
      credit_card = self.default_credit_card
      return false unless braintree_customer && credit_card

      result = Braintree::Transaction.sale(
      :amount => payment.amount,
      :customer_id => braintree_customer.id,
      :options => {
        :submit_for_settlement => true
      }
      )
      unless result.nil?
        payment.status = result.transaction.status
        payment.processing_response = result.transaction.processor_response_code
        result.errors.each{|error| payment.errors.add(error.attribute, error.message)} unless result.success?
        payment.errors.add(:payment, result.message) unless self.success_response_code?(result.transaction.processor_response_code)
        result.success?
      else
        false
      end
    rescue Exception => exception
      payment.errors.add(:payment, exception)
      false
    end
    
    def success_response_code? code
      [1000,1001,1002].include? code.to_i
    end

  end
end
