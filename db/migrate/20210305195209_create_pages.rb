class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :page_name
      t.string :hero_title
      t.text :hero_description
      t.string :cta_text
      t.string :cta_description
      t.string :section_heading
      t.string :section_p1
      t.string :section_p2
      t.string :section_p3
      t.string :background_color
      t.timestamps
    end
  end
end
