# SugarWater： 砂糖水クラス (ConcreteBuilder：ビルダーの実装部分)
class SugerWater
  attr_accessor :water, :suger
  def initialize(water, suger)
    @water = water
    @suger = suger
  end
end

# SugarWaterBuilder: 砂糖水を生成するためのインターフェイス (Builder)
class SugerWaterBuilder
  def initialize
    @suger_water = SugerWater.new(0, 0)
  end

  def add_suger(suger_amount)
    @suger_water.suger += suger_amount
  end

  def add_water(water_amount)
    @suger_water.water += water_amount
  end

  def result
    @suger_water
  end
end

# Director： 砂糖水の作成過程を取り決める
class Director
  def initialize(builder)
    @builder = builder
  end

  def cook
    @builder.add_water(150)
    @builder.add_suger(90)
    @builder.add_water(300)
    @builder.add_suger(35)
  end
end

builder = SugerWaterBuilder.new
director = Director.new(builder)
director.cook

p builder.result
