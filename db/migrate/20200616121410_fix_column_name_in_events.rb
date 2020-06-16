class FixColumnNameInEvents < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :creator_id, :creator
  end
end
