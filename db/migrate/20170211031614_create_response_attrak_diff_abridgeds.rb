class CreateResponseAttrakDiffAbridgeds < ActiveRecord::Migration[5.0]
  def change
    create_table :response_attrak_diff_abridgeds do |t|
      t.integer :ATT2
      t.integer :ATT5
      t.integer :QP2
      t.integer :QP3
      t.integer :QP5
      t.integer :QP6
      t.integer :QHS2
      t.integer :QHS5
      t.integer :QHI3
      t.integer :QHI4
      t.string :respondent_id
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
