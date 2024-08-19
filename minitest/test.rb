require 'minitest/autorun'
require './object_oriented/vending_machine'
require './object_oriented/drink/drink_type'
require './object_oriented/money/coin'

class VendingMachineTest < Minitest::Test
  def setup
    @vm = VendingMachine.new
  end

  def test_500円でコーラを購入
    drink = @vm.buy(Coin::FIVE_HUNDRED, DrinkType::COKE)
    change = @vm.refund

    assert_equal(true, drink.coke?)
    assert_equal('400', change.to_s)
  end

  def test_コーラの在庫が無いときにコーラは買えない
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    drink = @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    change = @vm.refund

    assert_nil(drink)
    assert_equal('100', change.to_s)
  end

  def testダイエットコーラの在庫が無いときにダイエットコーラは買えない
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::DIET_COKE)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::DIET_COKE)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::DIET_COKE)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::DIET_COKE)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::DIET_COKE)
    drink = @vm.buy(Coin::ONE_HUNDRED, DrinkType::DIET_COKE)
    change = @vm.refund

    assert_nil(drink)
    assert_equal('100', change.to_s)
  end

  def testお茶の在庫が無いときにお茶は買えない
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    drink = @vm.buy(Coin::ONE_HUNDRED, DrinkType::TEA)
    change = @vm.refund

    assert_nil(drink)
    assert_equal('100', change.to_s)
  end

  def test_釣り銭が足りないときにコーラは買えない
    @vm.buy(Coin::FIVE_HUNDRED, DrinkType::COKE)
    @vm.refund
    @vm.buy(Coin::FIVE_HUNDRED, DrinkType::COKE)
    @vm.refund
    drink = @vm.buy(Coin::FIVE_HUNDRED, DrinkType::COKE)
    change = @vm.refund

    assert_nil(drink)
    assert_equal('500', change.to_s)
  end
end
