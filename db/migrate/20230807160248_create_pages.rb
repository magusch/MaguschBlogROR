class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :page_name
      t.text :page_text
      t.boolean :navbar_display

      t.timestamps
    end
  end
end
