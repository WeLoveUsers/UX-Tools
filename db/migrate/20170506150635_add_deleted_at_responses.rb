class AddDeletedAtResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :deleted_at, :datetime
    add_index :projects, :deleted_at

    add_column :response_attrak_diffs, :deleted_at, :datetime
    add_index :response_attrak_diffs, :deleted_at

    add_column :response_attrak_diff_abridgeds, :deleted_at, :datetime
    add_index :response_attrak_diff_abridgeds, :deleted_at

    add_column :response_sus, :deleted_at, :datetime
    add_index :response_sus, :deleted_at

    add_column :response_deeps, :deleted_at, :datetime
    add_index :response_deeps, :deleted_at
  end
end
