class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :synopsis
      t.integer :page_count
      t.date :published_date
      t.string :isbn
      t.string :cover_image_url

      t.timestamps
    end
  end
end
