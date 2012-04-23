namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create(name: 'Emily Ellison',
                        email: 'emilyellison986@gmail.com',
                        password: 'Code3Knuckl3',
                        password_confirmation: 'Code3Knuckl3',
                        writer: false)
    admin.toggle!(:admin)
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 writer: true )
    49.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   writer: false)
    end
    49.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+50}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   writer: true)
    end
    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(1)
      summary = Faker::Lorem.sentence(1)
      users.each { |user| user.book_posts.create!(title: title, summary: summary) }
    end
  end
end