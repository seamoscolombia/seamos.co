# == Schema Information
#
# Table name: external_links
#
#  id              :integer          not null, primary key
#  url             :string
#  poll_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_project_link :boolean          default(FALSE)
#

class ExternalLink < ApplicationRecord
  belongs_to :poll
  validates_format_of :url, :with => URI::regexp(%w(http https))
end