# Builder

# 登場人物
# Director（ディレクタ）
# Builder（ビルダ）
# ConcreteBuilder（具体ビルダ）

# 必要になる場面
# オブジェクトの生成に大量のコードが必要
# オブジェクトを作り出すのが難しい
# オブジェクト生成時に必要なチェックを行いたい

class SugerWater
  attr_accessor :water, :suger
  def initialize(water, suger)
    @water = water
    @suger = suger
  end

  def add_material(suger_amount)
    @suger += suger_amount
  end
end

class SaltWater
  attr_accessor :water, :SaltWater
  def initialize(water, salt)
    @water = water
    @salt = salt
  end

  def add_material(salt_amount)
    @salt += salt_amount
  end
end

class WaterWithMaterialBuilder
  def initialize(class_name)
    @water_with_material = class_name.new(0, 0)
  end

  def add_material(material_amount)
    @water_with_material.add_material(material_amount)
  end

  def add_water(water_amount)
    @water_with_material.water += water_amount
  end

  def result
    @water_with_material
  end
end

# Director： 砂糖水の作成過程を取り決める
class Director
  def initialize(builder)
    @builder = builder
  end

  def cook
    @builder.add_water(150)
    @builder.add_material(90)
    @builder.add_water(300)
    @builder.add_material(35)
  end
end

builder = WaterWithMaterialBuilder.new(SaltWater)
director = Director.new(builder)
director.cook

p builder.result


builder = WaterWithMaterialBuilder.new(SugerWater)
director = Director.new(builder)
director.cook

p builder.result
