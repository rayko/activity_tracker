class Activity < ApplicationRecord
  belongs_to :user
  has_many :activity_hits, dependent: :delete_all

  validates :name, presence: true, uniqueness: true
end
