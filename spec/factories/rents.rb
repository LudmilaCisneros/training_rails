FactoryBot.define do
  factory :rent, class: Rent do
    user
    book
    from            { Faker::Date.between(from: '2014-01-01', to: '2014-01-10') }
    to              { Faker::Date.between(from: '2014-02-01', to: '2014-02-10') }
  end
end
