class CreateShortenedUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :shortened_urls do |t|
      t.text :original_url
      t.string :short_url
      t.integer :view_count, default: 0

      t.timestamps
    end

    add_index :shortened_urls, :short_url
  end
end
