class AddSettingsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :ask_user_ideas,             :boolean,     default: false
    add_column :projects, :ask_user_summary,           :boolean,     default: false
    add_column :projects, :ask_user_age,               :boolean,     default: false
    add_column :projects, :ask_user_gender,            :boolean,     default: false
    add_column :projects, :ask_user_occupation,        :boolean,     default: false
    add_column :projects, :ask_user_first_use_date,    :boolean,     default: false
    add_column :projects, :ask_user_usage_frequency,   :boolean,     default: false
    add_column :projects, :ask_user_group,             :boolean,     default: false
  end
end
