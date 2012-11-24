class Topic < ActiveRecord::Base
  belongs_to :subject

  has_many :objectives, dependent: :destroy
  has_many :questions, through: :objectives

  validates :name, presence: true, uniqueness: { scope: :subject}
  validates :subject, presence: true
end
