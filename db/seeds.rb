# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = Category.create ([{name: 'Animals'}, {name: 'Lifestyle'}, {name: 'Home'}, {name: 'Nature'}, {name: 'DIY'}, {name: 'Fashion'}, {name: 'Games'}, {name:'Sport'}, {name: 'History'}, {name:'Other'}, {name:'Psychology'}, {name:'Science'}])

locations = Location.create ([{city: 'Warsaw'}, {city: 'Krakow'}, {city: 'Bialystok'}, {city: 'Paris'}, {city: 'London'}, {city: 'New York'}, {city: 'Rome'}, {city:'Lublin'}, {city: 'Brussels'}])

User.create(email: 'blogowotest@gmail.com', password:'q1w2e3r4', name: 'admin', admin: true)