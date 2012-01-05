# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Section.exists?(1)
  Section.create(name: 'The Yorker')
end

unless PrivilegeList.exists?(1)
  PrivilegeList.create(level: 2,
                       addresses: 'webmaster@theyorker.co.uk',
                       start_date: Time.now - 5.years,
                       end_date: Time.now + 100.years)
end

unless User.exists?(1)
  User.create(name: 'Webmaster',
              email: 'webmaster@theyorker.co.uk',
              password: 'changeme',
              password_confirmation: 'changeme')
end
