class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = current_user.questions.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.includes(choices: :answers).friendly.find params[:id]
    @respondents_size = @question.respondents.count
    @choices = @question.choices.map do |choice|
      [choice.choice, choice.percentage]
    end
    set_meta_tags description: @choices.map(&:first).to_sentence(two_words_connector: ' or ', last_word_connector: ' or ')
    render template: 'questions/show_result' if view_context.show_result? @question
  end

  # GET /questions/new
  def new
    if params.has_key?(:random) && params[:random]
      @question = Question.random_new
    else
      @question = Question.new
      2.times { @question.choices.build }
    end
  end

  # GET /questions/1/edit
  def edit
    head 501
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user(true).questions.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = current_user.questions.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :mcq, :expiry, :allow_reuse, choices_attributes: [:id, :choice, :_destroy])
    end
end
