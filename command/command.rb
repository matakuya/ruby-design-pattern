# Command
# 説明
# コマンドデザインパターンは、あるオブジェクトに対してコマンドを送ることでそのオブジェクトのメソッドを呼び出すことです。
#
# たとえば、ファイルシステムの実装は知らなくてもユーザーはファイルの追加、削除といったコマンドを実行できます。これもコマンドパターンのひとつです。
# ですってよ

# 登場人物
# Command(コマンド)：コマンドのインターフェイス
# ConcreteCommand(具体コマンド)：Commandの具体的な処理

# 嬉しいこと
# コマンドの変更，追加，変更に対して柔軟になる

# 今回のモデル
# Commandクラス：すべてのCommandのインターフェイス
# CreateFileクラス(ConcreteCommand):ファイルを作成する
# DeleteFileクラス(ConcreteCommand):ファイルを削除する
# CopyFileクラス(ConcreteCommand):ファイルをコピーする
# CompositeCommand(ConcreteCommand):複数のコマンドをまとめて実行できるようにした、CreateFile, DeleteFile, CopyFileのコマンドを集約するクラス

# Command
class Command
  attr_reader :description
  def initialize(description)
    @description = description
  end

  def execute
  end

  def undo_execute
  end
end

# ConcreteCommand(s)
require "fileutils"
class CreateFile < Command
  def initialize(path, contents)
    super("Create file : #{path}")
    @path = path
    @contents = contents
  end

  def execute
    f = File.open(@path, "w")
    f.write(@contents)
    f.close
  end

  def undo_execute
    File.delete(@path)
  end
end

class DeleteFile < Command
  def initialize(path)
    super("Delete file : #{path}")
    @path = path
  end

  def execute
    if File.exists?(@path)
      @contents = File.read(@path)
    end
  end

  def undo_execute
    f = File.open(@path, "w")
    f.write(@content)
    f.close
  end
end

class CopyFile < Command
  def initialize(source, target)
    super("Copy file: #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    FileUtils.copy(@source, @target)
  end

  def undo_execute
    File.delete(@target)
    if(@contents)
      f = File.open(@target, "w")
      f.write(@contents)
      f.close
    end
  end
end

class CompositeCommand < Command
  def initialize
    @commands =[]
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each { |cmd| cmd.execute }
  end

  def undo_execute
    @commands.reverse.each { |cmd| cmd.undo_execute }
  end

  def description
    description = ""
    @commands.each { |cmd| description += cmd.description + "\n" }
    description
  end
end

# main
command_list = CompositeCommand.new
command_list.add_command(CreateFile.new("file_1.txt", "Hello, world.\n"))
command_list.add_command(CopyFile.new("file_1.txt", "file_2.txt"))
command_list.add_command(DeleteFile.new("file_1.txt"))

command_list.execute
puts(command_list.description)

# command_list.undo_execute
