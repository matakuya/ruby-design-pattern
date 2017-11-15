# Strategy

# 使用シーン
# 5ステップ週の3ステップが異なるA,Bがある．この2つをスイッチしたい

# 登場人物
# コンテキスト(Context)：ストラテジの利用者
# 抽象戦略(Strategy)：同じ目的をもった一連のオブジェクトを抽象化したもの
# 具象戦略(ConcreteStrategy)：具体的なアルゴリズム

# メリット
# 使用するアルゴリズムに多様性を持たせることができる
# コンテキストと戦略を分離することでデータも分離できる
# 継承よりもストラテジを切り替えるのが楽

# らしい

# 今回のモデル
# Report(コンテキスト)：レポートを表す
# Formatter(抽象戦略)：レポートの出力を抽象化したクラス
# HTMLFormatter(具象戦略1)：HTMLフォーマットでレポートを出力
# PlaneTextFormatter(具象戦略2)：PlanTextフォーマットでレポートを出力

# Strategy
class Formatter
  def output_report
    raise 'Called abstract method!!'
  end
end

# ConcreteStrategy
class HTMLFormatter
  def output_report(report)
    puts "<html><head><title>#{report.title}</title></head><body>"
    report.text.each { |line| puts "<p>#{line}</p>" }
    puts "</body></html>"
  end
end

# ConcreteStrategy
class PlaneTextFormatter
  def output_report(report)
    puts "***** #{report.title} *****"
    report.text.each { |line| puts(line) }
  end
end

# Context
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'report_title'
    @text = %w(text1 text2 text3)
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(self)
  end
end

report = Report.new(HTMLFormatter.new)
report.output_report

report.formatter = PlaneTextFormatter.new
report.output_report
