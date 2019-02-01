class Url < ApplicationRecord
  validates_format_of :original_url, with: /\A#{URI::regexp}\z/, message: 'is invalid.'
  validates_format_of :shortened_url, with: /\A(?!url)[a-zA-Z0-9_-]*\z/i, 
    message: 'can only consist of alphabets/numbers/underscores/hiphens, and cannot begin with \'url\'.'

  default_scope -> { order(updated_at: :desc) }
end
