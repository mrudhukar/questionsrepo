class Question < ActiveRecord::Base
  module Difficulty
    LOW = 0
    MEDIUM = 1
    HIGH = 2
  end

  belongs_to :objective
  
  has_many :choices, dependent: :destroy
  has_one :answer, class_name: "Choice", conditions: {correct: true}

  validates :title, :objective, presence: true
  validates :difficulty, presence: true, inclusion: { in: [Difficulty::LOW, Difficulty::MEDIUM, Difficulty::HIGH]} 

  # [:subject, :topic].each do |attribute|
  #   delegate attribute, to: :objective
  # end
  delegate :subject, to: :objective
  delegate :topic, to: :objective

end
