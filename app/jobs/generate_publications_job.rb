class GeneratePublicationsJob < ApplicationJob
  queue_as :default

  def perform
    ai_author = User.find_or_create_ai_author

    ['Economics', 'Politics'].each do |category|
      generated_content = AiPublicationGenerator.generate(category)

      ActiveRecord::Base.transaction do
        publication = Publication.create!(
          title: generated_content[:title],
          content: generated_content[:content],
          summary: generated_content[:summary],
          category: category,
          read_time: generated_content[:read_time],
          author: ai_author,
          ai_generated: true
        )

        generated_content[:sources].each do |source_data|
          source = Source.find_or_create_by!(
            name: source_data['name'],
            url: source_data['url']
          )
          publication.publication_sources.create!(source: source)
        end
      end
    end
  end
end

  # private

  # def create_ai_author
  #   User.create!(
  #     username: 'ai_author',
  #     email: 'ai@publications.com',
  #     first_name: 'AI',
  #     last_name: 'Author',
  #     role: User::AUTHOR,
  #     password: SecureRandom.hex(32),
  #     ai_bot: true
  #   )
  # end

