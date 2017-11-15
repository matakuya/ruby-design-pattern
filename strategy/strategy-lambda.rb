# Strategy

# 使用シーン
# 5ステップ中の3ステップが異なるA,Bがある．この2つをスイッチしたい

# 登場人物
# コンテキスト(Context)：ストラテジの利用者
# 抽象戦略(Strategy)：同じ目的をもった一連のオブジェクトを抽象化したもの
# 具象戦略(ConcreteStrategy)：具体的なアルゴリズム
# ストラテジのアイデアは、コンテキストが「委譲」によってアルゴリズムを交換できるようにすることです。
# 委譲とは、ある機能をもつオブジェクトを生成してオブジェクトに処理を依頼することです。

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

# 注意点
# コンテキストとストラテジ間のインターフェイスがストラテジの種類の増加を妨げないようにする
# コンテキストの変更がストラテジに影響を与えないようにする

# lambda 使って書き直した版
# ブロックのオブジェクト化

# Ruby の書き方で言えば不要らしい
# # Strategy
# class Formatter
#   def output_report
#     raise 'Called abstract method!!'
#   end
# end

# ConcreteStrategy
HTML_FORMATTER = lambda do |context|
  puts "<html><head><title>#{context.title}</title></head><body>"
  context.text.each { |line| puts "<p>#{line}</p>" }
  puts "</body></html>"
end

# ConcreteStrategy
PLANE_TEXT_FORMATTER = lambda do |context|
  puts "***** #{context.title} *****"
  context.text.each { |line| puts(line) }
end

# Context
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'report_title'
    @text = %w(text1 text2 text3)
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

report = Report.new(&HTML_FORMATTER)
report.output_report

# Strategyの入れ替え（スイッチ）
report.formatter = PLANE_TEXT_FORMATTER
report.output_report
