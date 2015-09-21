ActiveAdmin.register Page do

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :teaser, :input_html => { :rows => 5 }
      f.input :text, :input_html => { :class => :editor }
      f.input :slug
      f.input :order, :as => :select, :collection => [0,1,2,3,4,5,6,7,8,9,10]
      f.input :show_in_menu
    end

    f.buttons
  end

end
