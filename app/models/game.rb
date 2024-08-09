class Game < ApplicationRecord

  has_many :decks, dependent: :restrict_with_exception

end
