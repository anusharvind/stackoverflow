class AnswersController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@question = Question.find(params[:current_question])
  	@answer = @question.answers.build(answer_params)
  	@answer.user_id = params[:current_user]
  	@answer.votes = 0
  	@answer.is_answer = false
    if @answer.save
      flash[:success] = "Answer submitted!"
      redirect_to @question
    else
      @answerfeed_items = @question.answers.paginate(page: params[:page])
      redirect_to root_url
    end
  end

  def destroy
  	@answer.destroy
    flash[:success] = "Answer deleted"
    redirect_to request.referrer || root_url
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.question.answers.each { |a| a.update_attribute(:is_answer, false) if a.is_answer }
    @answer.update_attribute(:is_answer, true)
    redirect_to request.referrer
  end

  def upvote
    answer = Answer.find(params[:answerid])
    user = current_user
    vote = user.votes.find_by(answer_id: answer.id)
    if(vote.nil?)
      vote = Vote.new
      vote.user_id = user.id
      vote.answer_id = answer.id
      vote.value = 1
      vote.save
      answer.update_attribute(:votes, answer.votes + 1)
      flash[:success] = "Answer upvoted!"
      redirect_to request.referrer
    else
      if(vote.value == 1)
        flash[:info] = "You have already upvoted this answer"
        redirect_to request.referrer
      else
        vote.destroy
        answer.update_attribute(:votes, answer.votes + 1)
        flash[:success] = "Answer upvoted!"
        redirect_to request.referrer
      end
    end
  end

  def downvote
    answer = Answer.find(params[:answerid])
    user = current_user
    vote = user.votes.find_by(answer_id: answer.id)
    if(vote.nil?)
      vote = Vote.new
      vote.user_id = user.id
      vote.answer_id = answer.id
      vote.value = -1
      vote.save
      answer.update_attribute(:votes, answer.votes - 1)
      flash[:success] = "Answer downvoted!"
      redirect_to request.referrer
    else
      if(vote.value == -1)
        flash[:info] = "You have already downvoted this answer"
        redirect_to request.referrer
      else
        vote.destroy
        answer.update_attribute(:votes, answer.votes - 1)
        flash[:success] = "Answer downvoted!"
        redirect_to request.referrer
      end
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content)
    end

    def correct_user
      @answer = current_user.answers.find_by(id: params[:id])
      redirect_to root_url if @answer.nil?
    end

end
