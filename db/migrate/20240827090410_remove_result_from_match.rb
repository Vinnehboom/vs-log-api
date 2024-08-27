class RemoveResultFromMatch < ActiveRecord::Migration[7.1]

  class Match < ActiveRecord::Base
    self.table_name = 'matches'
    has_many :match_games
  end

  class MatchGame < ActiveRecord::Base
    self.table_name = 'match_games'
    belongs_to :match

    validates :result, inclusion: { in: %w[W L T ID] }
  end

  def change
    ActiveRecord::Base.transaction do
      gameless_matches = Match.includes(:match_games).all.filter { |match| match.match_games.blank? }
      ids = gameless_matches.filter { |g| g.result == "ID" }
      ids.each { |match| create_game(match:, result: "ID") }

      (gameless_matches - ids).each do |match|
        match.result.split("").each do |result|
          create_game(match:, result:)
        end
      end
    end

    remove_column :matches, :result
  end
end

def create_game(match:, result:)
  game = MatchGame.new(result:, started: false, match_id: match.id)
  game.save!
end

