# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Checking sections...\n"
unless Section.exists?(1)
  puts "Creating section with id=1\n"
  Section.create(name: 'The Yorker')
end


puts "Checking privilege lists...\n"
unless PrivilegeList.exists?(1)
  puts "Creating initial privilege list\n"
  PrivilegeList.create(level: 2,
                       addresses: ['webmaster@theyorker.co.uk',
                                   'editor@theyorker.co.uk',
                                   'director@theyorker.co.uk'].join("\r\n"),
                       start_date: Time.now - 5.years,
                       end_date: Time.now + 100.years)
  
end

puts "Checking users...\n"
unless User.where(:email => 'webmaster@theyorker.co.uk').exists?
  puts "Creating webmaster@theyorker.co.uk\n"
  User.create(name: 'Webmaster',
              email: 'webmaster@theyorker.co.uk',
              password: 'changeme',
              password_confirmation: 'changeme')
end

unless User.where(:email => 'editor@theyorker.co.uk').exists?
  puts "Creating editor@theyorker.co.uk"
  User.create(name: 'Editor',
              email: 'editor@theyorker.co.uk',
              password: 'changeme',
              password_confirmation: 'changeme')
end

puts "Checking editor privileges...\n"
unless User.find_by_email('editor@theyorker.co.uk').editor_for(Section.find(1))
  puts "Assigning global editor privileges to editor@theyorker.co.uk\n"
  Editor.create(section: Section.find(1),
                user: User.find_by_email('editor@theyorker.co.uk'))
end
