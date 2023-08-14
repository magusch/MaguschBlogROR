class Comment < ApplicationRecord
  has_many :comment_votes, dependent: :destroy
  include Visible
  belongs_to :article

  def voted_by?(user)
    user.comment_votes.exists?(comment: self)
  end

  def upvotes_count
    comment_votes.where(vote: true).count
  end
end
