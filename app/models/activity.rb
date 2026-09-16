class Activity < ApplicationRecord
  belongs_to :user
  has_many :activity_hits

  validates :name, presence: true, uniqueness: true
end
