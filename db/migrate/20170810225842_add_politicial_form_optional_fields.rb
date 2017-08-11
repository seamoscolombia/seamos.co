class AddPoliticialFormOptionalFields < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birthday, :date
    add_column :users, :birthplace, :string
    add_column :users, :profession, :string
    add_column :users, :university, :string
    add_column :users, :further_studies, :text
    add_column :users, :last_election_vote_count, :integer
    add_column :users, :represented_organizations, :text
    add_column :users, :major_electoral_representation_localities, :string
    add_column :users, :other_periods_elected, :string
    add_column :users, :current_corporation_commission, :integer
    add_column :users, :proposed_initiatives_to_date, :text
  end
end
