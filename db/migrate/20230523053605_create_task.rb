# frozen_string_literal: true

class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :work_focus
      t.date :due_date
      t.string :status, default: 'not_started'
      t.references :project, type: :uuid, foreign_key: { to_table: :projects }
      t.references :project_manager, type: :uuid, foreign_key: { to_table: :users }
      t.references :employee, type: :uuid, foreign_key: { to_table: :users }
      t.references :parent_task, type: :uuid, foreign_key: { to_table: :tasks }

      t.timestamps
    end
  end
end
