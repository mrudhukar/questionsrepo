class Subject < ActiveRecord::Base
  has_many :topics, dependent: :destroy
  has_many :objectives, through: :topics
  has_many :questions, through: :objectives

  validates :name, presence: true
end
