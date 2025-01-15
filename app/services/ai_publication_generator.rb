
class AiPublicationGenerator
  def self.generate(category)
    new(category).generate
  end

  def initialize(category)
    @category = category
  end

  def generate
    title = generate_title
    content = generate_content(title)
    summary = generate_summary(content)
    sources = find_sources(content)

    {
      title: title,
      content: content,
      summary: summary,
      sources: sources,
      category: @category,
      read_time: estimate_read_time(content)
    }
  end

  private

  def generate_title
    response = openai_client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{
                     role: "system",
                     content: "You are a professional economics/politics writer. Generate a compelling title for a publication."
                   }, {
                     role: "user",
                     content: "Generate a title for a #{@category} publication that's engaging and specific."
                   }],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")
  end

  def generate_content(title)
    response = openai_client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{
                     role: "system",
                     content: "You are a professional #{@category} writer creating an in-depth publication. Include specific data points and references."
                   }, {
                     role: "user",
                     content: "Write a detailed publication about: #{title}. Include real statistics and potential sources."
                   }],
        temperature: 0.7,
        max_tokens: 2000
      }
    )

    response.dig("choices", 0, "message", "content")
  end

  def generate_summary(content)
    response = openai_client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{
                     role: "system",
                     content: "Create a concise summary of the following publication."
                   }, {
                     role: "user",
                     content: content
                   }],
        temperature: 0.5,
        max_tokens: 150
      }
    )

    response.dig("choices", 0, "message", "content")
  end

  def find_sources(content)
    response = openai_client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{
                     role: "system",
                     content: "Extract or suggest relevant credible sources for the following content. Return as JSON array with 'name' and 'url' fields."
                   }, {
                     role: "user",
                     content: content
                   }],
        temperature: 0.5
      }
    )

    JSON.parse(response.dig("choices", 0, "message", "content"))
  end

  def estimate_read_time(content)
    words = content.split.size
    (words / 200.0).ceil # Assuming average reading speed of 200 words per minute
  end

  def openai_client
    @openai_client ||= OpenAI::Client.new
  end
end