ActiveAdmin.register Step do

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :description
      f.input :order, :as => :select, :collection => [0,1,2,3,4,5,6,7,8,9,10]
      f.input :slug
      f.input :locked_on_completion
      f.input :must_complete
    end

    f.buttons
  end

end
