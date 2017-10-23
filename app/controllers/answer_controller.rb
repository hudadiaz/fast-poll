class AnswerController < ApplicationController
  def create
    question = Question.friendly.find params[:id]
    current_user(true).answer_question(question, answer_params[:answer])
    redirect_to question
  end

  private

  def answer_params
    params.require(:question).permit(:answer, answer: [])
  end
end
