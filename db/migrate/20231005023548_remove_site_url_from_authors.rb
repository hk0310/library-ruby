class RemoveSiteUrlFromAuthors < ActiveRecord::Migration[7.0]
  def change
    remove_column(:authors, :site_url)
  end
end
