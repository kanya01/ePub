class Publication < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true, inclusion: { in: %w[Economics Politics] }

  belongs_to :author, class_name: 'User'
  has_many :publication_sources
  has_many :sources, through: :publication_sources

  scope :latest, -> { order(created_at: :desc).limit(3) }
  scope :by_category, ->(category) { where(category: category) }
  scope :ai_generated, -> { where(ai_generated: true) }

  def excerpt
    content.truncate(100)
  end
end
