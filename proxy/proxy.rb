# Proxy
#
# プロキシパターンは1つのオブジェクトに複数の関心ことがある場合にそれを分離するために用います。
# たとえば、オブジェクトの本質的な目的とは異なる「セキュリティ要件やトランザクション管理など」を切り離して実装できます。
#
# サッカーが専門の「サッカー選手」と、チームとの交渉や契約が専門の「代理人」のような関係です。

# 登場人物
# 対象オブジェクト(subject)：本物のオブジェクト
# 代理サブジェクト(proxy)：特定の「関心事」を担当、それ以外を対象サブジェクトに渡す

# プロキシオブジェクトは対象オブジェクトと同じインタフェースを持ちます。利用する際は、プロキシオブジェクトを通して対象となるオブジェクトを操作します。


# この例ではユーザ認証という「特定の関心事」をProxyオブジェクトに分離している
class BankAccount
  attr_reader :balance
  def initialize(balance)
    @balance = balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

# etcはRubyの標準ライブラリで、/etc に存在するデータベースから情報を得る
# この場合は、ログインユーザー名を取得するために使う
require 'etc'
class BankAccountProxy
  def initialize(real_object, owner_name)
    @real_object = real_object
    @owner_name = owner_name
  end

  def balance
    check_access
    @real_object.balance
  end

  def deposit(amount)
    check_access
    @real_object.deposit(amount)
  end

  def withdraw(amount)
    check_access
    @real_object.withdraw(amount)
  end

  def check_access
    if(Etc.getlogin != @owner_name)
      raise "Illigal access: #{@owner_name} cannot access account."
    end
  end
end

# BankAccountProxyのmethod_missing使ったバージョン
class MethodMissingBankAccountProxy
  def initialize(real_object, owner_name)
    @real_object = real_object
    @owner_name = owner_name
  end

  # 移譲
  # 未定義のメソッド，ここではdeposit, withdrawをreal_object側に移譲してる
  def method_missing(name, *args)
    check_access
    @real_object.send(name, *args)
  end

  def check_access
    if(Etc.getlogin != @owner_name)
      raise "Illigal access: #{@owner_name} cannot access account."
    end
  end
end

# should pass
account = BankAccount.new(100)
proxy = BankAccountProxy.new(account, "mikake")
puts proxy.deposit(50)
#=> 150
puts proxy.withdraw(10)
#=> 140

# should pass
account = BankAccount.new(100)
proxy = MethodMissingBankAccountProxy.new(account, "mikake")
puts proxy.deposit(50)
#=> 150
puts proxy.withdraw(10)
#=> 140

# should not pass
account = BankAccount.new(100)
proxy = BankAccountProxy.new(account, "no_login_user")
puts proxy.deposit(50)
# `check_access': Illigal access: no_login_user cannot access account. (RuntimeError)
