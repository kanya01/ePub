class Source < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, format: { with: URI::regexp(%w[http https]) }

  has_many :publication_sources
  has_many :publications, through: :publication_sources
end
