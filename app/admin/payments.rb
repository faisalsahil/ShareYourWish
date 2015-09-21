ActiveAdmin.register Payment do

   index do
     column :id
     column :order_id, :label=>'Order id'
     column :contribution_id, :label=>'Contribution id'
     column :amount
     column :payment_method
     column :last_four_digits
     column :processing_response
     column :status
     column :created_at
     column :updated_at

     default_actions
   end
   
   show do |item|
     attributes_table do
        row :id
        row :order_id
        row :contribution_id
        row :amount
        row :payment_method
        row :last_four_digits
        row :processing_response
        row :status
        row :created_at
        row :updated_at
     end
     active_admin_comments
   end
  
end
