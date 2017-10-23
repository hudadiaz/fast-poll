class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :choices, inverse_of: :question
  has_many :respondents, -> { distinct }, through: :answers, source: :user
  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user, :question

  def self.random_new
    if id = self.select(:id).where(allow_reuse: true).map(&:id).shuffle.first
      p id
      template = self.find id
      new_question = self.new(
        question: template.question,
        mcq: template.mcq
      )
      template.choices.each do |template_choice|
        new_question.choices.build(choice: template_choice.choice)
      end
    else
      new_question = self.new
      2.times { new_question.choices.build }
    end
    new_question
  end
end
