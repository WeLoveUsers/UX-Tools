class AddIndexToProjects < ActiveRecord::Migration[5.0]
  def change
    add_index :projects, :uri_token, unique: true
  end
end
