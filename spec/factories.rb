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
    out_title 'Example Title'
    out_subtitle 'Example Sub-Title'
    out_genre 'Example Genre'
    out_summary 'Example Summary'
    user
  end
end