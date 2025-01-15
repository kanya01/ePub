class PublicationComment < ApplicationRecord
  belongs_to :user
  belongs_to :publication, counter_cache: true
end
