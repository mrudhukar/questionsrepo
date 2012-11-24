class Question < ActiveRecord::Base
  module Difficulty
    LOW = 0
    MEDIUM = 1
    HIGH = 2

    V_TO_S = {Difficulty::LOW => "Low", Difficulty::MEDIUM => "Medium", Difficulty::HIGH => "HIGH"}
    S_TO_V = {"Low" => Difficulty::LOW, "Medium" => Difficulty::MEDIUM, "HIGH" => Difficulty::HIGH}

  end

  belongs_to :objective
  
  has_many :choices, dependent: :destroy
  has_one :answer, class_name: "Choice", conditions: {correct: true}

  accepts_nested_attributes_for :choices, :allow_destroy => true

  validates :title, :objective, presence: true
  validates :difficulty, presence: true, inclusion: { in: [Difficulty::LOW, Difficulty::MEDIUM, Difficulty::HIGH]} 

  delegate :subject, to: :objective
  delegate :topic, to: :objective

end
