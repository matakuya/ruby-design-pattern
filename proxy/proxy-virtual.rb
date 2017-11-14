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

# 入出金を行うBankAccountクラス
# BankAccountのインスタンス生成を遅らせるためのVirtualAccountProxyクラスを作成
# この例では「BankAccountインスタンスの生成タイミング」という関心事の分離をしている

# Subject
class BankAccount
  attr_reader :balance
  def initialize(balance)
    puts "BankAccount object has been generated."
    @balance = balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

# Proxy
# BankAccountの生成を遅らせる仮想Proxy
class VirtualAccountProxy
  def initialize(starting_balance)
    puts "VirtualAccountProxy has been generated. BankAccount has not been generated yet."
    @starting_balance = starting_balance
  end

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  def announce
    "This announcement has been announced by VirtualAccountProxy."
  end

  def subject
    @subject || (@subject = BankAccount.new(@starting_balance))
  end
end

proxy = VirtualAccountProxy.new(100)

puts proxy.announce

puts proxy.deposit(50)

puts proxy.withdraw(10)
