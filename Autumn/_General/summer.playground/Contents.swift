//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var view = UIView(frame: CGRectMake(0, 0, 200, 300))
view.backgroundColor = UIColor.redColor()




/**
分析购房
*/

/**
参考结论:
https://www.v2ex.com/t/224104#;     结论是   能向银行借多少就借多少，能拖多少年就拖多少年。把自己的钱留下来投资，能赚钱，跑赢CPI就足够。
n年后的1W跟现在的1Q完全不同。另外楼市崩盘也是时间题，如果n年内崩盘，损失全大部分由银行承担，自己可以放弃，然后重新购房，自己付的越多，承受损失越
大。
*/



let beforePay = 100 * 10000.0 //当前房价
let firstPay = 20 * 10000.0 //首付
let debitYears = 30.0 //借贷年数
let debitInterestRate = 2.2750 * 0.01 //借贷利率 2.2750%

/**
一次性本息倍率 = (1 + 利率)^还贷年数
*/
func principalWithInterestRate(interestRate:Double, debitYears:Double) -> Double {
    return pow((1.0 + interestRate), debitYears)
}
let _principalWithInterestRate = principalWithInterestRate(debitInterestRate,debitYears:debitYears)

/**
月供 = (房价 - 首付) * 本息倍率 / 30年 / 12个月
*/
func monthPay(beforePay:Double, firstPay:Double, principalWithInterestRate:Double) -> Double {
    return (beforePay - firstPay) * principalWithInterestRate / 30.0 / 12.0
}
let _monthPay = monthPay(beforePay, firstPay: firstPay, principalWithInterestRate:_principalWithInterestRate)
/**
假设在武汉买一套100万房子，首府20万，30年利息 2.2750%利率，月还款4364。
*/



/**
如果个人会投资，月入出去月供，生活支出后有结余，按年投资
将当前投资成功保留以供购车，旅游，医疗，养老等，不作为月供
*/
let wage = 10000.0  //2年后 预估在武汉的长期工作收入水平
let livingExpenses = 3000.0 //生活总支出
let investmentGrowthRate = 8.000 * 0.01 //均衡投资增长率

/**
每年剩余 = (工资 - 生活基本支出 - 月供) * 12个月
第1年 每年剩余 * (1 + 年投资增长)^借贷年数
第2年 每年剩余 * （(1 + 年投资增长)^借贷年数-1）
第3年 每年剩余 * （(1 + 年投资增长)^借贷年数－2)
...
总计自由资产
*/

func freeFund(wage:Double, livingExpenses:Double, monthPay:Double,debitYears:Int) -> Double {
    var sum = 0.0
    for var debitYear = 0; debitYear < debitYears; debitYear += 1 {
        sum += (wage - livingExpenses - monthPay) * 12 * pow(1 + investmentGrowthRate, Double(debitYears - debitYear))
    }
    return sum
}
let _freeFund = freeFund(wage, livingExpenses: livingExpenses, monthPay: _monthPay,debitYears:Int(debitYears))












