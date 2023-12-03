class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true, on: :create
  validates :original_url, url: { public_suffix: true }

  before_create :generate_short_url

  def generate_short_url
    self.short_url = rand(36**8).to_s(36)
  end
end
