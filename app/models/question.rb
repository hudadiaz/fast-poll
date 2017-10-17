class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :choices, inverse_of: :question
  has_many :respondents, -> { distinct }, through: :answers, source: :user
  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user, :question
end
