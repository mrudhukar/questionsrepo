class Objective < ActiveRecord::Base
  belongs_to :topic

  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :topic_id}
  validates :topic, presence: true

  delegate :subject, to: :topic
end
