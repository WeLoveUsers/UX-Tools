class AddDetailsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :is_closed, :boolean, :default => false
  end
end
