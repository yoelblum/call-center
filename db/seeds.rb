# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

director = Director.create!(name: 'the director', status: 0)
manager = Manager.create!(name: 'the manager', status: 0, manager: director)
respondent = Respondent.create!(name: 'respondent', status: 0, manager: manager)
