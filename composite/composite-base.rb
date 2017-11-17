# Composite

# 参考元にページがみつからなかったので
# https://qiita.com/kidach1/items/6cb73b2bbc875e9bef6d
# を参照

# 概要
# あるものが同じような下位のもので作られているという考え方
# 大きなオブジェクトが小さな子オブジェクトから構成されていて、その子オブジェクトもさらに小さな孫オブジェクトでできている
# 階層構造やツリー構造のオブジェクトを作りたい時に利用できる。

# 登場人物
# コンポーネント（Component）
# すべてのオブジェクトの共通インターフェイス。もしくは基底クラス。
# 基本的なオブジェクトや上位のオブジェクトいずれも、必ず共通して共通して持っているもの。
# 例）ケーキ作成手順を例にとると、タスクの所要時間
#
# 葉（Leaf）
# プロセスの単純な構成要素で、１つ以上必要。
# 例）小麦粉の計量や卵の投入など単純タスク
#
# コンポジット（Composite）
# コンポーネントの一部だが、サブコンポーネントから作られる、より上位のオブジェクト。
# いくつかの小タスクから構成される複合的なタスク。
# 例）生地の作成など、いくつかの子タスクから構成される複合的なタスク


# Component
class Task
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def get_time_required
    0.0
  end
end

# Leaf
class AddMIlkTask < Task
  def initialize
    super('Add dry inredients.')
  end

  def get_time_required
    1.0
  end
end

# Leaf
class MixTask < Task
  def initialize
    super('Mix that batter up!')
  end

  def get_time_required
    3.0
  end
end

# Composite
# コンポジットタスクが複数でてくることを見越して、コンポジット用基底クラスを作成
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def get_time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.get_time_required }
    time
  end
end

# Composite
class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    add_sub_task(AddMIlkTask.new)
    add_sub_task(MixTask.new)
  end
end

# Composite
class MakeCakeTask < CompositeTask
  def initialize
    super('Make cake')
    add_sub_task(MakeBatterTask.new)
  end
end

make_batter = MakeBatterTask.new
p make_batter.get_time_required

make_cake = MakeCakeTask.new
p make_cake.get_time_required
