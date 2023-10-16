class ChangeAuthorsBirthDateDataType < ActiveRecord::Migration[7.0]
  def change
    change_column(:authors, :birth_date, :string)
  end
end
