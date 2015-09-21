class CreateEventTransactionLogs < ActiveRecord::Migration
  def change
    create_table :event_transaction_logs do |t|
      t.integer :event_transaction_log_category_id
      t.string :description
      t.string :memo
      t.decimal :event_fund, :precision => 10, :scale => 2, :default => 0.0
      t.decimal :gift_fund, :precision => 10, :scale => 2, :default => 0.0
      t.decimal :donation_fund, :precision => 10, :scale => 2, :default => 0.0
      t.decimal :syw_fund, :precision => 10, :scale => 2, :default => 0.0
      t.references :contribution 
      t.references :event
      t.references :payment
      t.references :charity

      t.timestamps
    end
  end
end
