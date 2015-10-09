# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)





  user = User.create!(email: "testa@mailinator.com", password: '12345678', user_type: 1 )
  Artist.create!(user: user, full_name: "Artist full name", music_genre: "Test genre", country_id: "IN", zip: "452001")
  
  user = User.create!(email: "testb@mailinator.com", password: '12345678', user_type: 2 )
  Band.create!(user: user, band_name: "Band Name", music_genre: "Test genre", country_id: "IN", zip: "452001")
  
  user = User.create!(email: "testc@mailinator.com", password: '12345678', user_type: 3 )
  Client.create!(user: user, company_name: "company name", company_email: "companyemail@mailinator.com", official_website: "http://google.com", country_id: "IN", zip: "452001")  


