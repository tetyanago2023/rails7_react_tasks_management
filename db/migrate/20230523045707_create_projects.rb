# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.references :project_manager, type: :uuid, foreign_key: { to_table: :users }
      t.references :employee, type: :uuid, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
