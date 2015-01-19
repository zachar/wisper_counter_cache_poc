class Player < ActiveRecord::Base

  has_many :players_teams
  has_many :teams, through: :players_teams, counter_cache: false

end
