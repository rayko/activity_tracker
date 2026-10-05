class AddArchivedToActivities < ActiveRecord::Migration[8.1]
  def change
    add_column :activities, :archived, :bool
  end
end
