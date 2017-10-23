class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers

  validates_presence_of :choice

  def percentage
    return 0 unless answers.present?
    total = Answer.where(question: question).size
    answers.size * 100.0 / total
  end
end
