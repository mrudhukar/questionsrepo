class Choice < ActiveRecord::Base
  belongs_to :question

  validates :question, presence: true
  validates :value, presence: true, uniqueness: { scope: :question}
end
