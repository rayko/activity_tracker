class Activity < ApplicationRecord
  belongs_to :user
  has_many :activity_hits, dependent: :delete_all

  validates :name, presence: true, uniqueness: { scope: :user_id }

  scope :active, -> { where(archived: [ false, nil ]) }
  scope :archived, -> { where(archived: true) }

  def archive!
    return if archived == true

    update(archived: true)
  end

  def unarchive!
    return unless archived == true

    update(archived: false)
  end
end
