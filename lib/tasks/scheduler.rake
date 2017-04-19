desc "This task is called by the Heroku scheduler add-on"
task :close_projects => :environment do
  puts "Closing project based on their 'end_date' ..."
  Project.all.each do |p|
    if p.should_get_closed
      p.is_closed = true
      p.save
    end
  end
  puts "done."
end
