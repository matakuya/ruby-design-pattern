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


# クラスを変更したほうがシンプルになるのではないか
# 次の判断材料を元に、「クラス変更」か「アダプタ適用」を選択してください。
#
# 問題のクラスの理解がある、変更が比較的少ない => クラス変更
# オブジェクトが複雑/完全な理解がない => アダプタ適用

# ということらしいです


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

  def show_with_paren
    puts "(#{@string})"
  end

  def show_with_aster
    puts "*#{@string}*"
  end
end

# Adopter
class Adopter
  def initialize(string)
    @old_printer = OldPrinter.new(string)
  end

  def print_weak
    @old_printer.show_with_paren
  end

  def print_strong
    @old_printer.show_with_aster
  end
end

p = Printer.new(Adopter.new("Hello"))
p.print_weak

p.print_strong
