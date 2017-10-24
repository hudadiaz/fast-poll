class RecentsController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc).limit(13)
  end
end
