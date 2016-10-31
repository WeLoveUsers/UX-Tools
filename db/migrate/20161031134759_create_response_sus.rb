class CreateResponseSus < ActiveRecord::Migration[5.0]
  def change
    create_table :response_sus do |t|
      t.integer :Q1
      t.integer :Q2
      t.integer :Q3
      t.integer :Q4
      t.integer :Q5
      t.integer :Q6
      t.integer :Q7
      t.integer :Q8
      t.integer :Q9
      t.integer :Q10
      t.string :respondent_id
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
