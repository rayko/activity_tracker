class Activity < ApplicationRecord
  belongs_to :user
  has_many :activity_hits, dependent: :delete_all

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
