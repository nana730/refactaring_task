# This class is for representing one row in the league table.
module Poros
  class LeagueTableRow
    attr_accessor :club, :rank, :year, :matches, :digested_games_count, :win, :lost, :draw, :goals, :goals_conceded, :goal_difference, :points

    def initialize(club, year)
      @club = club
      @year = year
      @rank = nil
      @matches = club.matches_on(year)
    @digested_games_count = @matches.count
    @win = club.win_on(year)
    @lost = club.lost_on(year)
    @draw = club.draw_on(year)
    @goals = @matches.sum {|match| match.goal_by(club) } || 0
    @goals_conceded =   @matches.sum {|match| match.goal_conceded_by(club) } || 0
    @goal_difference = @goals - @goals_conceded
    @points = @win * League::WIN_POINTS + @draw * League::DRAW_POINTS
    end
  end
end

