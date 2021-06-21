require 'factory_bot_rails'
require 'faker'

ActiveRecord::Base.transaction do
    User.create(email: 'test@widergy.com', password: '123123123', password_confirmation: '123123123', first_name: 'Test', last_name: 'TestLastName')
    FactoryBot.create_list(:rent, 5)
    AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
end
