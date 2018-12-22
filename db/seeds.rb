# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Category.create(description: '海外就職')
Category.create(description: 'キャリア')
Category.create(description: '留学/MBA')
Category.create(description: '移住')
Category.create(description: '現地情報')
Category.create(description: '語学留学')
Category.create(description: '異文化/人間関係')
Category.create(description: '国内のグローバル化')

Area.create(description: 'グローバル')
Area.create(description: 'アジア')
Area.create(description: '北アメリカ')
Area.create(description: '南アメリカ')
Area.create(description: 'ヨーロッパ')
Area.create(description: 'アフリカ')
Area.create(description: 'オセアニア')
Area.create(description: '日本')
