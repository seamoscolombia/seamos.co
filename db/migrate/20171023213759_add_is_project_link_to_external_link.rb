class AddIsProjectLinkToExternalLink < ActiveRecord::Migration[5.0]
  def change
    add_column :external_links, :is_project_link, :boolean, :default => false
  end
end
