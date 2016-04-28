class CommentsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]

  def create
  	if(params[:qa] == "1")
  	  @comment = Question.find(params[:question_id]).comments.build(comment_params)
  	  @comment.question_id = params[:question_id]
  	else
  	  @comment = Answer.find(params[:answer_id]).comments.build(comment_params)
  	  @comment.answer_id = params[:answer_id]
  	end
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment posted!"
      redirect_to request.referrer
    else
      redirect_to request.referrer
    end
  end

  def destroy
    Comment.find(params[:commentid]).destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :question_id, :answer_id)
    end

end
