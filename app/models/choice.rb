class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers

  validates :choice,
    presence: true,
    length: {maximum: 40},
    allow_nil: false

  def percentage
    return 0 unless answers.present?
    total = question.answers.size
    (answers.size * 100.0 / total).round(1)
  end
end
