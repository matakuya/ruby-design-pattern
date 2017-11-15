# Observer

# 使用シーン
# オブジェクトの状態が変化する可能性がある
# 変化したことをほかのオブジェクトに通知する必要がある

# 登場人物
# サブジェクト(subject)：変化する側のオブジェクト
# オブザーバ(Observer)：状態の変化を関連するオブジェクトに通知するインタフェース
# 具象オブザーバ(ConcreteObserver)：状態の変化に関連して具体的な処理を行う

# 嬉しいこと
# オブジェクト間の依存度を下げることができる
# 通知先の管理をオブザーバが行うことで、サブジェクトは通知側を意識しなくていい

# 今回のモデル
# Employee(サブジェクト)：従業員を表す
# Observable(オブザーバ)：従業員のニュースを監視するしくみ(observer/Observable)
# Payroll(具体オブザーバ1)：給与の小切手の発行を行う
# TaxMan(具体オブザーバ2)：税金の請求書の発行を行う


require 'observer'
class Employee
  include Observable
# add_observerメソッドで通知する先のオブジェクトを追加
# changedメソッドとnotify_observersメソッドでオブジェクトに通知

  attr_reader :name, :title, :salary

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    # ConcreteObserverの追加
    add_observer(Payroll.new)
    add_observer(TaxMan.new)
  end

  # ConcreteObserverに通知する
  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end

# ConcreteObserver
class Payroll
  def update(changed_employee)
    puts "#{changed_employee.name}\'s salaly become #{changed_employee.salary}. A new check will be issued for #{changed_employee.title}."
  end
end

# ConcreteObserver
class TaxMan
  def update(changed_employee)
    puts "An account of tax will be sent to #{changed_employee.name}."
  end
end

john = Employee.new('John', 'Senior Vice President', 5000)
john.salary = 6000
john.salary = 7000
