FactoryBot.define do
  factory :article do
    title { "Sample Article" }
    body { "Lorem ipsum" }
    status { "public" }
    #user # Associate the article with a user by default using the user factory
  end
end