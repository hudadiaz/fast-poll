class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :answered_questions, through: :answers, source: :question

  before_validation :generate_secret
  validates_presence_of :uuid, :secret

  def merge user
    User.reflect_on_all_associations(:has_many).map do |belongings|
      user.send(belongings).update_all(user_id: self.id)
    end
  end

  def answer_question question, choices
    Array(choices).each do |choice|
      self.answers.create(question: question, choice_id: choice)
    end
  end

  def answered question
    Answer.find_by user: self, question: question
  end

  private

  def generate_secret
    self.secret = "#{uuid.split('-').last}#{SecureRandom.urlsafe_base64}"
  end
end
