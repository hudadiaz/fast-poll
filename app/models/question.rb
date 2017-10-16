class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :choices, inverse_of: :question
  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user, :question

  def stats
    answers.grouped(:choice).count
  end
end
