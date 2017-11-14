# Factory Method
#
# ファクトリメソッドは、インスタンスの生成をサブクラスに任せるパターンです。
# インスタンスの生成部分を切り離すことで、結合度を下げて追加・変更・保守を容易にします。
# らしい．

# 登場人物
# Creator: ConcreteFactoryの共通部分の処理を行う(InstrumentFactory)
# ConcreteCreator: 実際にオブジェクトの生成を行う(SaxophoneFactory, TrumpetFactory)
# Product: ConcreteFactoryによって生成される側のオブジェクト(Saxophone、Trumpet)

# Product
class Saxophone
  def initialize(name)
    @name = name
  end

  def play
    puts "Saxophone #{@name} is making a beautiful sound."
  end
end

# Product
class Trumpet
  def initialize(name)
    @name = name
  end

  def play
    puts "Trumpet #{@name} is making a beautiful sound."
  end
end

# Creator
class InstrumentFactory
  def initialize(number_instruments)
    @instruments = []
    number_instruments.times do |i|
      instrument = new_instrument("instrument_#{i}")
      @instruments << instrument
    end
  end

  def ship_out
    @tmp = @instruments.dup
    @instruments = []
    @tmp
  end
end

# ConcreteCreator
class SaxophoneFactory < InstrumentFactory
  def new_instrument(name)
    Saxophone.new(name)
  end
end

# ConcreteCreator
class TrumpetFactory < InstrumentFactory
  def new_instrument(name)
    Trumpet.new(name)
  end
end


factory = SaxophoneFactory.new(3)
saxophones = factory.ship_out
saxophones.each { |saxophone| saxophone.play }

factory = TrumpetFactory.new(3)
trumpets = factory.ship_out
trumpets.each { |trumpet| trumpet.play }
