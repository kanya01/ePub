FactoryBot.define do
  factory :publication_comment do
    user { nil }
    publication { nil }
    content { "MyText" }
  end
end
