class AnswerController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find params[:id]
    current_user.answer_question(question, answer_params[:answer])
    redirect_to question
  end

  private

  def answer_params
    params.require(:question).permit(:answer, answer: [])
  end
end
