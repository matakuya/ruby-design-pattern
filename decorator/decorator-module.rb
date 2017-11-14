# Decorator

# メリット
# 既存のオブジェクトの中身を変更することなく、機能を追加できる
# 組み合わせでさまざまな機能を実現できる
# 継承よりも変更の影響を限定しやすい

# 登場人物
# SimpleWriter(具体コンポーネント)：ファイルへの単純な出力を行う
# NumberingWriter(デコレータ)：行番号出力を装飾する機能をもつ
# TimestampingWriter(デコレータ)：タイムスタンプを追加する機能をもつ

# Concrete Component
class SimpleWriter
  def initialize(path)
    @file = File.open(path, "w")
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

# Decorator
class WriterDecorator
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.write_line(line)
  end

  def pos
    @real_writer.pos
  end

  def rewind
    @real_writer.rewind
  end

  def close
    @real_writer.close
  end
end

# Decorator
# Decoratorをモジュール化しても同様の機能を実現できる
module NumberingWriter
  attr_reader :line_number

  def write_line(line)
    @line_number = 1 unless @line_number
    super("#{@line_number} : #{line}")
    @line_number
  end
end

# Decorator
module TimestampingWriter
  def write_line(line)
    super("#{Time.new} : #{line}")
  end
end

# By Concrete Component
writer = SimpleWriter.new('file_0.txt')
writer.write_line('sample text.')
writer.close

# extendメソッドは、オブジェクトの特異クラスにモジュールを取り込み、
# モジュールのメソッドを特異メソッドとして使えるようにします。
# 取り込むモジュールは引数moduleに指定します（複数指定できます）。
# 戻り値はレシーバ自身です。
# https://ref.xaio.jp/ruby/classes/object/extend
f = SimpleWriter.new('file_1.txt')
f.extend TimestampingWriter
f.extend NumberingWriter
f.write_line('Hello out there')
f.close
