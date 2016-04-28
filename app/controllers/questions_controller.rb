class QuestionsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy, :show]
  before_action :correct_user,   only: :destroy

  def create
  	@question = current_user.questions.build(question_params)
    @question.votes = 0
    if @question.save
      flash[:success] = "Question posted!"
      redirect_to root_url
    else
      @feed_items = current_user.questions.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted"
    redirect_to current_user
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    @answers = @question.answers.paginate(page: params[:page])
    @comments = @question.comments.paginate(page: params[:page])
    if logged_in?
      @answer  = @question.answers.build
      @answerfeed_items = @question.answerfeed.paginate(page: params[:page])
      @comment = @question.comments.build
    end
  end

  def upvote
    question = Question.find(params[:id])
    user = current_user
    vote = user.votes.find_by(question_id: question.id)
    if(vote.nil?)
      vote = Vote.new
      vote.user_id = user.id
      vote.question_id = question.id
      vote.value = 1
      vote.save
      question.update_attribute(:votes, question.votes + 1)
      flash[:success] = "Question upvoted!"
      redirect_to request.referrer
    else
      if(vote.value == 1)
        flash[:info] = "You have already upvoted this question"
        redirect_to request.referrer
      else
        vote.destroy
        question.update_attribute(:votes, question.votes + 1)
        flash[:success] = "Question upvoted!"
        redirect_to request.referrer
      end
    end
  end

  def downvote
    question = Question.find(params[:id])
    user = current_user
    vote = user.votes.find_by(question_id: question.id)
    if(vote.nil?)
      vote = Vote.new
      vote.user_id = user.id
      vote.question_id = question.id
      vote.value = -1
      vote.save
      question.update_attribute(:votes, question.votes - 1)
      flash[:success] = "Question downvoted!"
      redirect_to request.referrer
    else
      if(vote.value == -1)
        flash[:info] = "You have already downvoted this question"
        redirect_to request.referrer
      else
        vote.destroy
        question.update_attribute(:votes, question.votes - 1)
        flash[:success] = "Question downvoted!"
        redirect_to request.referrer
      end
    end
  end

  private

    def question_params
      params.require(:question).permit(:title, :content)
    end

    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end

end
