ActiveAdmin.register HelpMessage do

  index do
    column :id
    column :code
    column :text
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :code
      f.input :text, :input_html => { :class => :help_editor }
    end

    f.buttons
  end
  
  show do |help_message|
    attributes_table do
      row :code
      row :text
      row :helper do |hm|
        hm.helper
      end
      row :ajax_helper do |hm|
        hm.ajax_helper
      end
    end
    active_admin_comments
  end

end
