class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :duration
      t.integer :word_per_lesson

      t.timestamps
    end
  end
end
