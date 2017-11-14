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
require 'forwardable'
class WriterDecorator
  extend Forwardable

  # forwardableで以下のメソッドの処理を委譲している
  # Forwardableモジュールは、def_delegatorsメソッドを持っており、第一引数には委譲先のオブジェクト、それ以降の引数で委譲したいメソッド名を指定する。
  def_delegators :@real_writer, :write_line, :pos, :rewind, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end

  # def write_line(line)
  #   @real_writer.write_line(line)
  # end
  #
  # def pos
  #   @real_writer.pos
  # end
  #
  # def rewind
  #   @real_writer.rewind
  # end
  #
  # def close
  #   @real_writer.close
  # end
end

# Decorator
class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number} : #{line}")
  end
end

# Decorator
class TimestampingWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line("#{Time.new} : #{line}")
  end
end

# By Concrete Component
writer = SimpleWriter.new('file_0.txt')
writer.write_line('sample text.')
writer.close

# By Decorator
f = NumberingWriter.new(SimpleWriter.new("file_1.txt"))
f.write_line("Hello out there")
f.close

f = TimestampingWriter.new(SimpleWriter.new("file_2.txt"))
f.write_line("Hello out there")
f.close

f = TimestampingWriter.new(NumberingWriter.new(SimpleWriter.new("file_3.txt")))
f.write_line("Hello out there")
f.close
