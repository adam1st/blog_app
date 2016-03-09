class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  
  validates :body, presence: 
  
  def self.persisted
    where.not(id: nil)
  end
end
