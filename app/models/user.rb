class User < ApplicationRecord
  has_many :questions
  has_many :answers

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

  def answered choice
    Answer.find_by user: self, choice: choice
  end

  private

  def generate_secret
    self.secret = SecureRandom.base64(64)
  end
end
