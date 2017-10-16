class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers

  validates_presence_of :choice
end
