class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers

  validates :choice,
    presence: true,
    length: {maximum: 60},
    allow_nil: false

  def percentage
    return 0 unless answers.present?
    total = Answer.where(question: question).size
    answers.size * 100.0 / total
  end
end
