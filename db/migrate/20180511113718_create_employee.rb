class CreateEmployee < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :type
      t.string :name
      t.integer :manager_id
      t.integer :status, default: 0
    end
  end
end
