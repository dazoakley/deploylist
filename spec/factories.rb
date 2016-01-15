FactoryGirl.define do
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
