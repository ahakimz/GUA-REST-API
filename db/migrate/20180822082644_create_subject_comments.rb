class CreateSubjectComments < ActiveRecord::Migration[5.2]
  def change
    create_table :subject_comments do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
