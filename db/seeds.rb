# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

nfc = NfcDevice.create(nfc_id: "123456789")
order = Order.create(status: 'Pending')
nfc.order = order
nfc.save

User.create(email: "test@john.com", password: "123", group: "seller")
User.create(email: "buyer@john.com", password: "123", group: "buyer")