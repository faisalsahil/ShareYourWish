class ChangePaymentsProcessingResponse < ActiveRecord::Migration
 def self.up
    change_table :payments do |t|
      t.change :processing_response, :string, :default => Payment::PROCESSING_RESPONSES.keys[0]
    end
  end
  def self.down
    change_table :payments do |t|
      t.change :processing_response, :string
    end
  end
end
