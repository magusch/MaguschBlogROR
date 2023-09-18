class Article < ApplicationRecord
  include Visible
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images
  has_one_attached :thumbnail

  # Define a thumbnail version of the image

  def thumbnail
    image.variant(resize: '100x100')
  end

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
