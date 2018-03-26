class AddUserDetailsToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :response_attrak_diff_abridgeds, :ideas,                     :text
    add_column :response_attrak_diff_abridgeds, :summary,                   :text
    add_column :response_attrak_diff_abridgeds, :age,                       :integer,     default: 0
    add_column :response_attrak_diff_abridgeds, :gender,                    :integer,     default: 0
    add_column :response_attrak_diff_abridgeds, :occupation,                :string
    add_column :response_attrak_diff_abridgeds, :first_use_on,              :datetime
    add_column :response_attrak_diff_abridgeds, :usage_frequency_per_month, :integer,     default: 0
    add_column :response_attrak_diff_abridgeds, :group,                     :integer,     default: 0

    add_column :response_attrak_diffs, :ideas,                     :text
    add_column :response_attrak_diffs, :summary,                   :text
    add_column :response_attrak_diffs, :age,                       :integer,     default: 0
    add_column :response_attrak_diffs, :gender,                    :integer,     default: 0
    add_column :response_attrak_diffs, :occupation,                :string
    add_column :response_attrak_diffs, :first_use_on,              :datetime
    add_column :response_attrak_diffs, :usage_frequency_per_month, :integer,     default: 0
    add_column :response_attrak_diffs, :group,                     :integer,     default: 0

    add_column :response_deeps, :ideas,                     :text
    add_column :response_deeps, :summary,                   :text
    add_column :response_deeps, :age,                       :integer,     default: 0
    add_column :response_deeps, :gender,                    :integer,     default: 0
    add_column :response_deeps, :occupation,                :string
    add_column :response_deeps, :first_use_on,              :datetime
    add_column :response_deeps, :usage_frequency_per_month, :integer,     default: 0
    add_column :response_deeps, :group,                     :integer,     default: 0

    add_column :response_sus, :ideas,                     :text
    add_column :response_sus, :summary,                   :text
    add_column :response_sus, :age,                       :integer,     default: 0
    add_column :response_sus, :gender,                    :integer,     default: 0
    add_column :response_sus, :occupation,                :string
    add_column :response_sus, :first_use_on,              :datetime
    add_column :response_sus, :usage_frequency_per_month, :integer,     default: 0
    add_column :response_sus, :group,                     :integer,     default: 0
  end
end
