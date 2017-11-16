# Abstract Factory
# 矛盾のないオブジェクトの生成を行うためのパターンです。

# 今回のモデル
# 動物を表すクラス：
# アヒルを表すDuckクラスは、食事(eat)メソッドを持っている
# カエルを表すFrogクラスは、食事(eat)メソッドを持っている
#
# 植物を表すクラス：
# 藻を表すAlgaeクラスは、成長(grow)メソッドを持っている
# スイレンを表すWaterLilyクラスは、成長(grow)メソッドを持っている
#
# 池の生態系を生成するクラス：
# コンストラクタで動物と植物を定義する
# 動物、植物のオブジェクトを返すメソッドを持っている
#
# 池の環境(動物と植物の組み合わせ)は次の2種類のみが許されている
# DuckとWaterLily
# FrogとAlgae

# 以上の制約を守る，つまり矛盾のないオブジェクトの組み合わせを作る
# DuckとWaterLily : FrogAndAlgaeFactory
# FrogとAlgae : DuckAndWaterLilyFactory
# 以上の2つのクラスのベース : OrganismFactory

# 登場人物
# AbstractFactory：ConcreteFactoryの共通部分の処理を行う
# ConcreteFactory：実際にオブジェクトの生成を行う
# Product：ConcreteFactoryによって生成される側のオブジェクト

# メリット
# 関連し合うオブジェクトの集まりを生成できる
# 整合性が必要となるオブジェクト群を誤りなしに生成できる


# Products
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts "Duck #{@name} has a meal now."
  end
end

class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts "Frog #{@name} has a meal now."
  end
end

class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts "Algae #{@name} is growing now."
  end
end

class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "WaterLily #{@name} is growing now."
  end
end

# AbstractFactory
class OrganismFactory
  def initialize(number_animals, number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("animal_#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_plant("plant_#{i}")
      @plants << plant
    end
  end

  def get_plants
    @plants
  end

  def get_animals
    @animals
  end
end

# ConcreteFactory
class FrogAndAlgaeFactory < OrganismFactory
  private

  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

# ConcreteFactory
class DuckAndWaterLilyFactory < OrganismFactory
  private

  def new_animal(name)
    Duck.new(name)
  end

  def new_plant(name)
    WaterLily.new(name)
  end
end

# main
factory = FrogAndAlgaeFactory.new(4, 1)
animals = factory.get_animals
animals.each { |animal| animal.eat }
plans = factory.get_plants
plans.each { |plant| plant.grow }

factory = DuckAndWaterLilyFactory.new(3, 2)
animals = factory.get_animals
animals.each { |animal| animal.eat }
plans = factory.get_plants
plans.each { |plant| plant.grow }
