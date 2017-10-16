class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :choice

  validates_presence_of :choice_id, :user_id, :question_id
  validates_uniqueness_of :user_id, scope: [:question_id, :choice_id]
end
