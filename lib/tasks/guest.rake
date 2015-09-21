
# rake guest:send_reminder_fortyeight
namespace :guest do
  desc "Send 48-hour reminder for guests"
  task :send_reminder_fortyeight => :environment do 
    counter = 0
    Guest.event.within_fortyeight_hours.find_each do |guest|
      begin
        guest.remind_fortyeight!
        counter += 1
      rescue Exception => e
        #  puts "#{e} @ guest.id = #{guest.id}\n #{e.backtrace}"
      end
    end
    puts "#{counter} guests reminded."
  end
end


# DEPRECATED: We are not programmatically sending invitations to guests. Let the Host manage this manually.

# rake guest:send_invitation
namespace :guest do
  desc "Send invitation for guests"
  task :send_invitation => :environment do 
    counter = 0
    Guest.visible.invite_not_sent.find_each do |guest|
      begin
        guest.invite!
        counter += 1
      rescue Exception => e
        #  puts "#{e} @ guest.id = #{guest.id}\n #{e.backtrace}"
      end
    end
    puts "#{counter} guests invited."
  end
end

