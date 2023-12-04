class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true, on: :create
  validates :original_url, url: { public_suffix: true }

  before_create :generate_short_url

  def generate_short_url
    url = rand(36**8).to_s(36)
    duplicate_short_url = ShortenedUrl.where(short_url: url).last

    if duplicate_short_url.present?
      self.generate_short_url
    else
      self.short_url = url
    end
  end
end
