class AnswersController < ApplicationController
  before_action :correct_user, only: [:index, :show, :create]
  
  def index
    @answer_requests = current_user.requests
  end

  def show
    @answer_request = Request.find(params[:id])
    @answer = Answer.new
    @user = User.find(params[:user_id])
    @question = @answer_request.question
  end

  def create
    answer = Answer.new(answer_params)
    request = answer.question.requests.find_by(user_id: current_user.id)
    if answer.save
      redirect_to user_answers_path
    else
      redirect_to user_answer_path(user_id: answer.user_id, id: request.id)
    end
  end


  private
  def answer_params
    params.require(:answer).permit(:content,:question_id, :image).merge(user_id: params[:user_id])
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_path) if current_user != @user
  end

end
