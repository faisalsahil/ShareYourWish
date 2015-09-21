class AddPayTransactionFeeToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :pay_transaction_fee, :boolean, :default => false
  end
end
