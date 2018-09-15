class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: 'Comment was successfully created.'
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to @comment.commentable
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:commentable_id, :commentable_type, :body)
    end
end
