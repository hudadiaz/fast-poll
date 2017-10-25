class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :answered_questions, through: :answers, source: :question

  before_validation :generate_uuid
  before_validation :generate_secret
  validates_presence_of :uuid, :secret

  def self.from_jwt_token token
    payload = (JWT.decode token, nil, false).first
    if user = User.find_by(uuid: payload['uuid'])
      JWT.decode token, user.secret, true, { :algorithm => 'HS256' }
      user
    end
  end

  def jwt_token
    JWT.encode ({ uuid: uuid }), secret, 'HS256'
  end

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

  def reset_secret
    self.generate_secret true
    self.save
  end

  def generate_secret force=false
    self.secret = "#{uuid.split('-').last}#{SecureRandom.urlsafe_base64}" if force || self.secret.blank?
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid unless self.uuid.present?
  end
end
