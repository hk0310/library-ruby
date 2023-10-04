class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :site_url
      t.text :bio
      t.date :birth_date
      t.string :photo_url

      t.timestamps
    end
  end
end
