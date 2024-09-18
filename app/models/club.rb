class Club < ApplicationRecord
  has_one_attached :logo

  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"
  has_many :players
  belongs_to :league

  def matches
    Match.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

  def matches_on(year = nil)
    return nil unless year

    matches.where(kicked_off_at: Date.new(year, 1, 1).in_time_zone.all_year)
  end

  def won?(match)
    match.winner == self
  end

  def lost?(match)
    match.loser == self
  end

  def draw?(match)
    match.draw?
  end

  def win_on(year)
    matches_winner_count(year) { |match| won?(match)}
  end

  def lost_on(year)
    matches_winner_count(year) { |match| lost?(match)}
  end

  def draw_on(year)
    matches_winner_count(year) { |match| draw?(match)}
  end

  def average_player_age
    (players.sum(&:age) / players.length).to_f
  end
end

private

def matches_winner_count(year)
  #yearインスタンスには、2013.1.1が入る
year = Date.new(year, 1, 1)
  #countを0に初期化する
count = 0
  #matchesテーブルの2013年全てのkicked_off_atをmatchに配列で入れる
matches.where(kicked_off_at: year.all_year).each do |match|
  #ifでmatches_winner_count(year)を使ってるメソッドにmatchを代入してく。→
  count += 1 if yield(match)
end
count
end

