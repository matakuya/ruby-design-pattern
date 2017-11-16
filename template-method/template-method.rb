# Template Method
# 2つのコードのやりたいこと(アルゴリズム)がほとんど同じで、ある一部だけ変えたいようなパターンのときに有効です。

# 登場人物
# 骨格としての「抽象的なベースのクラス」
# 実際の処理を行う「サブクラス」

# メリット
# 抽象的なベースのクラス側に、「変わらない基本的なアルゴリズム」を置ける
# 抽象的なベースのクラスは「高レベルの処理」を制御することに集中できる
# サブクラス側に、「変化するロジック」を置ける
# サブクラスは「詳細を埋めること」に集中できる

# 高レベルの処理っていうのは抽象度の高い処理って言い換えができるっぽい

# 注意
# 「YAGNI = You Aren't Going to Need It.（今必要なことだけ行う）」を徹底する
# 解決したい問題に絞って単純なコードを書いていくこと

# 今回のモデル
# Report(抽象的なベースのクラス)： レポートを出力する
# HTMLReport(サブクラス)： HTMLフォーマットでレポートを出力
# PlaneTextReport(サブクラス)： PlanTextフォーマットでレポートを出力

# AbstractClass
class Report
  def initialize
    @title = "html report title"
    @text = ["report line 1", "report line 2", "report line 3"]
  end

  def output_report
    output_start
    output_body
    output_end
  end

# 抽象クラスで定義して、サブクラスでオーバライドすることができる
  def output_start
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_end
  end

# 抽象クラスで具体的な実装をせず、サブクラス側だけ定義することができる
  def output_line
    reise 'Called abstract method!!'
  end
end

# SubClass (ConcreteClass)
class HTMLTextReport < Report
  def output_start
    puts "<html><head><title>#{@title}</title></head><body>"
  end

  def output_line(line)
    puts "<p>#{line}</p>"
  end

  def output_end
    puts "</body></html>"
  end
end

# SubClass (ConcreteClass)
class PlaneTextReport < Report
  def output_start
    puts "**** #{@title} ****"
  end

  def output_line(line)
    puts line
  end
end


# main
html_report = HTMLTextReport.new
html_report.output_report

plane_text_report = PlaneTextReport.new
plane_text_report.output_report
