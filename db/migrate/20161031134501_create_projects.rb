class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :questionnaire_id
      t.string :questionnaire_language
      t.string :product_type
      t.string :product_name
      t.string :project_code
      t.datetime :end_date
      t.string :uri_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
