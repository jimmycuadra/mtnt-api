FactoryGirl.define do
  factory :entry do
    noun "foo"
    needs true
    verb "bar"
    user
  end

  factory :user do
    name "Starla Jade"
    api_key SecureRandom.uuid
  end
end
