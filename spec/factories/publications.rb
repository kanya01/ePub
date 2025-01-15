FactoryBot.define do
  factory :publication do
    title { "MyString" }
    author { "MyString" }
    summary { "MyText" }
    keywords { "MyString" }
    readability_score { 1 }
    word_count { 1 }
    summary_word_count { 1 }
  end
end
