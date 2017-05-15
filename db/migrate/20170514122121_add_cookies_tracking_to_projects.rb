class AddCookiesTrackingToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :forbid_multiple_reponses, :boolean, :default => false
  end
end
