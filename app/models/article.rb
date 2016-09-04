class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :category
  validates :title, presence: true, length: { minimum: 5 }

  default_scope { order(created_at: :desc) }
end
