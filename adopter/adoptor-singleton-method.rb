# Adapter
#
# 利用シーン
# 関連性・互換性のないオブジェクトどうしを結び付ける必要があります
# 他のコンポーネントへの変更ができるようにします
#
# アダプタの構成要素は次の4つです。
#
# 利用者(Client)：ターゲットのメソッドを呼び出す
# ターゲット(Target)：インターフェースを規定します
# アダプタ(Adapter)：アダプティのインターフェースを変換してターゲット向けのインターフェースを提供
# アダプティ(Adaptee)：実際に動作する既存のクラス

# Ruby の特異メソッドを使うとシンプルに書けるよって話らしいよ

# Target
class Printer
  def initialize(obj)
    @obj = obj
  end

  def print_weak
    @obj.print_weak
  end

  def print_strong
    @obj.print_strong
  end
end

# Adoptee
class OldPrinter
  def initialize(string)
    @string = string.dup
  end

  def show_with_bracket
    puts "[#{@string}]"
  end

  def show_with_asterisk
    puts "**#{@string}**"
  end
end

# OldPrinterのインスタンスにAdopterの役割を持つ特異メソッドを追加
text = OldPrinter.new("Hello")
def text.print_weak
  show_with_bracket
end
def text.print_strong
  show_with_asterisk
end

# Client
p = Printer.new(text)

p.print_weak
#=> [Hello]

p.print_strong
#=> **Hello**
