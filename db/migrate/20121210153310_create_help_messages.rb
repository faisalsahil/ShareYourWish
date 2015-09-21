class CreateHelpMessages < ActiveRecord::Migration
  def change
    create_table :help_messages do |t|
      t.string :code
      t.text :text

      t.timestamps
    end
    add_index :help_messages, :code
    HelpMessage.create([{:code => '101-CVV', :text =>'The Card Verification Code is located on the back of your credit card above the signature line. In the case of American Expres.....'},
                        {:code => '102-Donation-Fund', :text =>'The donation fund is the portion of each guest\'s contribution that is.....'}])
  end
end
