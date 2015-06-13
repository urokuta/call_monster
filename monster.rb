class Monster
  attr_accessor :id, :name, :pass, :hp, :wake, :atk, :element, :ability
  def initialize(options)
    self.id = options[:id]
    self.name = options[:name]
    self.pass = options[:pass]
    self.hp = options[:hp]
    self.wake = options[:wake]
    self.atk = options[:atk]
    self.element = options[:element]
    self.ability = options[:ability]
  end

  def action(defense_monsters)
    if wake <= 0
      target = defense_monsters.last
      original_hp = target.hp
      target.hp -= self.atk
      puts "ATTACK! #{name} => #{target.name} HP: #{original_hp} => #{target.hp}(#{self.atk})"
      if target.hp <= 0
        defense_monsters.pop()
      end
    else
      self.wake -= 1
    end
  end

  def to_s
    "id: #{id}, wake: #{wake}, hp: #{hp}, atk: #{atk}, name: #{name}"
  end
end
