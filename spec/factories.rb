FactoryGirl.define do
  factory :user do
    name 'Bob Fleming'
    email 'bob.fleming@cough.com'
    provider 'google_oauth2'
    sequence(:uid)
  end

  factory :deploy do
    sequence(:uid)
    sha '10f0393d'
    username 'Jesper'
    environment 'production'
    time Time.now
  end

  factory :story do
    deploy
    message('Story Message')
    date Time.now
    pull_request_uid('123456789')
    title('Story Title')
  end
end
