# Factory Method
#
# ファクトリメソッドは、インスタンスの生成をサブクラスに任せるパターンです。
# インスタンスの生成部分を切り離すことで、結合度を下げて追加・変更・保守を容易にします。
# らしい．

# 登場人物
# Product
# Creater
# このままだとInstrumentFactory.initialize()でProductを作っているためにInstrumentFactoryで他の楽器を作れないじゃんね

# Product
class Saxophone
  def initialize(name)
    @name = name
  end

  def play
    puts "#{@name} is making a beautiful sound."
  end
end

# Creator
class InstrumentFactory
  def initialize(number_saxophones)
    @saxophones = []
    number_saxophones.times do |i|
      saxophone = Saxophone.new("saxophone_#{i}")
      @saxophones << saxophone
    end
  end

  def ship_out
    @tmp = @saxophones.dup
    @saxophones = []
    @tmp
  end
end

factory = InstrumentFactory.new(3)
saxophones = factory.ship_out
saxophones.each { |saxophone| saxophone.play }
