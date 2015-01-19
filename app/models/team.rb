class Team < ActiveRecord::Base

  has_many :players_teams
  has_many :players, through: :players_teams

end