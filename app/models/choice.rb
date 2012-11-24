class Choice < ActiveRecord::Base
  belongs_to :question

  # TODO fix this (Mysql Validation is present)
  # validates :question, presence: true
  validates :value, presence: true, uniqueness: { scope: :question_id}
end
