FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
    writer false
    
    factory :admin do
      admin true
    end
  end
  
  factory :book_post do
    title 'Example Title'
    subtitle 'Example Sub-Title'
    genre 'Example Genre'
    summary 'Example Summary'
    user
  end
  
  factory :book_bite do
    bite 'Something about something.'
    user
  end
end