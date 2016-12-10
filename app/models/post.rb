# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  title            :string
#  body             :text
#  description      :text
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  banner_image_url :string
#  author_id        :integer
#  publishe_at      :datetime
#  published        :boolean          default(FALSE)
#  published_at     :datetime
#
# Indexes
#
#  index_posts_on_author_id  (author_id)
#  index_posts_on_slug       (slug) UNIQUE
#

class Post < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :author

  scope :most_recent, -> { order(published_at: :desc) }
  scope :published, -> {where.not(published_at: nil)}

  def should_generate_new_friendly_id?
    title_changed?
  end

  def display_day_published
    "Published: #{published_at.strftime('%-b %-d %Y')}"
  end

  def published?
    published_at.present?
  end

  def publish
    update(published: true, published: Time.now)
  end

  def unpublish
    update(published: false, published: nil)
  end

end
