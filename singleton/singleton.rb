# Singleton

# シングルトンパターンは、1つだけに限定されたインスタンスを複数のオブジェクト内で共有する場合に用います。
# たとえば、ログの書込処理を行うメソッドでのファイルへのアクセスや、システム内で共通のキャッシュテーブルを参照する場合などです。

# 前提条件
# 作成したクラスは唯一1つだけのインスタンスを自身で作成する
# システム内のどこでもその1つだけのインスタンスにアクセスできる

# だってさ

# 使いどころ
# アプリケーションで一度だけ読めばいい設定ファイルの内容のコンテナなど
# コネクションプーリングのように作成したインスタンスをプールして使いまわすとき

# Singletonには次のような課題があるため、安易に使わず、必要な箇所に使うようにすべきです。
#
# グローバル変数の代わりになると、複数箇所で変更されるとカオスになる
# コードが密結合になりやすく、テストを書きづらくなる

# とのこと

require 'singleton'

class SingletonObject
  # instanceメソッドが定義されて, newメソッドがprivateメソッドになる
  include Singleton
  attr_accessor :counter

  def initialize
    @counter = 0
  end
end

obj1 = SingletonObject.instance
obj1.counter += 1
puts(obj1.counter)
# 1

obj2 = SingletonObject.instance
obj2.counter += 1
# 2
puts(obj2.counter)

# Should be error: private method `new' called for SingletonObject:Class .
obj2 = SingletonObject.new
