require './monster'
class CallMonster
  attr_accessor :monsters

  def set_monsters
    ms = [
      %w(1 スペルパス pas 10 1 3 physics none),
      %w(2 ホネガシラ hone 30 3 6 fire none),
      %w(3 ツノダンゴ tuno 35 5 9 physics none),
      %w(4 スノーダンサー hoihoi 40 4 9 ice none),
      %w(5 ギョック uoza 60 7 12 fire none),
      %w(6 グラスホーン wadasen 80 7 12 ice none),
      %w(7 スケルトス sensi 40 5 9 fire resist_fire),
      %w(8 シャーベラット abc 30 1 6 ice none),
    ]
    @monsters = []
    ms.each do |m|
      @monsters << Monster.new(
        id: m[0],
        name: m[1],
        pass: m[2],
        hp: m[3].to_i,
        wake: m[4].to_i,
        atk: m[5].to_i,
        element: m[6],
        ability: m[7]
      )
    end
  end

  def my_monsters
    [
      @monsters[0].clone,
      @monsters[1].clone,
      @monsters[2].clone,
      @monsters[3].clone,
    ]
  end

  def enemy_monsters
    [
      @monsters[4].clone,
      @monsters[5].clone,
      @monsters[6].clone,
      @monsters[7].clone,
    ]
  end

  def battle
    set_monsters
    my = my_monsters
    enemy = enemy_monsters

    my = initial_phase(my_monsters)
    enemy = initial_phase(enemy_monsters)
    initial_wakeup(enemy)
  end

  def initial_phase(monsters)
    monsters[1].wake -= 2
    monsters[2].wake -= 4
    monsters[3].atk *= 2
    monsters
  end

  def initial_wakeup(monsters)
    monsters.map{|m| m.wake -= 1}
  end
  
  def turn(attackers, defenders)
    attackers.each do 
      attacker.action(defenders)
    end
  end
end
