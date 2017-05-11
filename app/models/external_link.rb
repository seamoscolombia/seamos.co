class ExternalLink < ApplicationRecord
    validates_format_of :url, :with => URI::regexp(%w(http https))
end
