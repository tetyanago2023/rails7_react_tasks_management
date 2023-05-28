# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :title
      t.string :work_focus
      t.string :type

      t.timestamps
    end
  end
end
