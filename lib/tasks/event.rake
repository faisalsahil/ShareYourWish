# rake event:funds_unlock_if_eligible
namespace :event do
  desc "Check date and unlock funds"
  task :funds_unlock_if_eligible => :environment do 
    counter = 0
    Event.with_locked_funds.find_each do |event|
      begin
        event.funds_unlock_if_eligible!
        counter += 1
      rescue Exception => e
          puts "#{e} @ event.id = #{event.id}\n #{e.backtrace}"
      end
    end
    puts "#{counter} events reviewed for funds unlock eligibility."
  end
  
  # rake event:contributions_lock_if_eligible
  desc "Check date and lock contributions"
  task :contributions_lock_if_eligible => :environment do 
    counter = 0
    Event.with_unlocked_contributions.find_each do |event|
      begin
        event.contributions_lock_if_eligible!
        counter += 1
      rescue Exception => e
          puts "#{e} @ event.id = #{event.id}\n #{e.backtrace}"
      end
    end
    puts "#{counter} events reviewed for contribution lock eligibility."
  end

end
