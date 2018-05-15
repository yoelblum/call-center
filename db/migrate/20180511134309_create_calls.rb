class CreateCalls < ActiveRecord::Migration[5.0]
  def change
    create_table :calls do |t|
      t.integer :employee_id
      t.integer :status, default: 0
      t.integer :escalation
    end
  end
end
