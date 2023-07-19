class CommentVotesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @comment_vote = @comment.comment_votes.build(user: current_user, vote: true)
    @comment_vote.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment_vote = current_user.comment_votes.find_by(comment_id: params[:comment_id])
    @comment_vote.destroy if @comment_vote
    redirect_back(fallback_location: root_path)
  end
end
