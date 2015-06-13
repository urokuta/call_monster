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
      %w(7 スケルトス sensi 40 4 12 physics none),
      %w(8 モエボン mera 40 5 9 fire resist_fire),
      %w(9 シャーベラット abc 30 1 6 ice none),
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
    puts "@@@@@@@@@@@@@ INITIAL STATUS @@@@@@@@@@@@@"
    print_both(my, enemy)

    initial_phase(my)
    initial_phase(enemy)

    puts "@@@@@@@@@@@@@ INITIAL PHASE @@@@@@@@@@@@"
    print_both(my, enemy)

    puts "@@@@@@@@@@@@@ INITIAL WAKEUP ME @@@@@@@@@@@@"
    initial_wakeup(my)

    puts "@@@@@@@@@@@@@ INITIAL WAKEUP ENEMY @@@@@@@@@@@@"
    initial_wakeup(enemy)

    pair = [{name: :enemy, monsters: enemy}, {name: :my, monsters: my}]
    loop do
      attacker_name = pair.first[:name].upcase
      puts "@@@@@@@@@@@@@@@@ #{attacker_name} TURN @@@@@@@@@@@@@@@@@"
      attackers = pair.first[:monsters]
      defenders = pair.last[:monsters]
      result = turn(attackers, defenders)
      print_both(attackers, defenders)
      if result == :game_end
        return "#{attacker_name} WIN"
      end
      pair = [pair.last, pair.first]
    end
  end

  def initial_phase(monsters)
    monsters[1].wake -= 2
    monsters[2].wake -= 4
    monsters[3].atk *= 2
    monsters
  end

  def initial_wakeup(monsters)
    monsters.each do |m|
      if m.wake == 1
        puts "WAKE UP : #{m.name}"
      end
      m.wake -= 1 if m.wake > 0
    end
  end
  
  def turn(attackers, defenders)
    attackers.each do |a|
      a.action(defenders)
      if defenders.size == 0
        return :game_end
      end
    end
    return :continue
  end

  def print(monsters)
    monsters.each do |m|
      puts "   " + m.to_s
    end
  end

  def print_both(attackers, defenders)
    puts ""
    puts "   ### ATTACKERS ###" 
    print(attackers)
    puts "   ### DEFENDERS ###" 
    print(defenders)
  end
end
