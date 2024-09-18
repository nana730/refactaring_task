# app/decorators/player_decorator.rb
class PlayerDecorator
  def initialize(player)
    @player = player
  end

  def full_name
    "#{@player.firstname} #{@player.lastname}"
  end

  def position
    @player.position
  end

  def country
    @player.country
  end

  def age
    @player.age
  end

  def birthday
    @player.birthday
  end
end
