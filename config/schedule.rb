# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# I don't think this is what we want... we don't want to auto-send invitations. Host should do than only if/when they want
#every 1.hour do
#  rake "guest:send_invitation"
#end

every 1.day, :at => '4:00 am' do
  rake "event:funds_unlock_if_eligible"
end

every 1.day, :at => '4:10 am' do
  rake "event:contributions_lock_if_eligible"
end

every 1.day, :at => '4:30 am' do
  rake "guest:send_reminder_fortyeight"
end

# This is a little indiscriminate... I want to be sure what/when we're clearing here exactly (Cache, Sessions, Sockets individually perhaps)
#every 2.weeks, :at => '1:00 am' do
#  rake 'tmp:clear'
#end

every 1.day, :at => '2:00 am' do
  rake '-s sitemap:refresh'
end

