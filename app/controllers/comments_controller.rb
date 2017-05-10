class CommentsController < ApplicationController
  before_action :redirect_logged_out
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:body))
    @comment.creator = current_user
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
  
  def vote
    @comment = Comment.find(params[:id])
    vote_boolean = params[:vote]
    vote = Vote.create(vote: vote_boolean, user_id: current_user.id, voteable: @comment)
    
    if vote.valid?
      flash[:success] = "Vote counted!"
      redirect_to :back
    else
      flash[:error] = "You can only vote for that once."
      redirect_to :back
    end
  end
end
