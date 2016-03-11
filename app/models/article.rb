class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user
  acts_as_votable
  has_many :comments, dependent: :destroy
  
  default_scope { order(created_at: :desc)}
end 