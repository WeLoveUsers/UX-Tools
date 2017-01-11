class AddInstructionsToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :instructions, :text
  end
end
