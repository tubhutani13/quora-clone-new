class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_many :comments, as: :commentable

  has_rich_text :answer_body
  validates_presence_of :answer_body
end
