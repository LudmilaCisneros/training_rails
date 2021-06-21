FactoryBot.define do
  factory :book, class: Book do
    genre            { Faker::Book.genre }
    author           { Faker::Book.author }
    image            { Faker::Internet.url(host: 'url.com', path: '/photo/') }
    title            { Faker::Book.title }
    publisher        { Faker::Book.publisher }
    year             { Faker::Number.between(from: 1900, to: 2021) }
  end
end
