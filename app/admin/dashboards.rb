ActiveAdmin::Dashboards.build do


    
  section "Recent Events", :priority => 1 do
    table do
      thead do
        tr do
          th 'ID'
          th 'Title'
          th 'Status'
          th 'Sequence Step'
          th 'Event date'
          th 'User'
          th 'Event Page (as Host)'
          th 'Order'
        end
      end
      Event.order("`created_at` DESC").limit(10).each do |event|
        tr do
          td link_to(event.id, sywadmin_event_path(event))
          td event.title
          td event.status
          td event.event_sequence
          td event.event_date
          td link_to(event.user.full_name, sywadmin_user_path(event.user))
          td link_to(event.title, event_path(event.id, :preview=>true))
          td link_to(event.order.id, sywadmin_order_path(event.order)) if event.order.present?
        end
      end
    end
  end

 # section "Steps", :priority => 2 do
 #   ul do
 #     Step.limit(10).collect do |step|
 #       li link_to(step.title, sywadmin_step_path(step))
 #     end
 #   end
 # end
  
end