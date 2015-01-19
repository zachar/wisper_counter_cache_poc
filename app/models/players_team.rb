class PlayersTeam < ActiveRecord::Base

  include WisperCounterCache

  belongs_to :player
  belongs_to :team

  wisper_counter_cache_attrs :player, column: :players_counter
  wisper_counter_cache_attrs :team, column: :teams_counter

end
