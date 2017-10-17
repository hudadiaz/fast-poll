class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = current_user.answered_questions.order(created_at: :desc)
  end
end
