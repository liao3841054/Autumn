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
假设在武汉买一套100万房子，首府20万，借80W，30年利息100％，月还款约4K，    毫无压力，而且30年后的4K跟现在的4K完全不同。另外楼市崩盘也是时间
题，如果30年内崩盘，损失全大部分由银行承担，自己可以放弃，然后重新购房，自己付的越多，承受损失越大。
*/


let beforePay = 200 * 10000.0 //当前房价
let firstPay = 20 * 10000.0 //首付
let debitYears = 30.0 //借贷年数
let debitInterestRate = 2.2750 * 0.01 //借贷利率 2.2750%

/**
本息倍率 = (1 + 利率)^还贷年数
*/
func principalWithInterestRate(interestRate:Double, debitYears:Double) -> Double {
    return pow((1.0 + interestRate), debitYears)
}
principalWithInterestRate(debitInterestRate,debitYears:debitYears)

/**
月供 = (房价 - 首付) * 本息倍率 / 30年 / 12个月
*/
func monthPay(beforePay:Double, firstPay:Double) -> Double {
    return (beforePay - firstPay) * principalWithInterestRate(debitInterestRate,debitYears:debitYears) / 30.0 / 12.0
}
monthPay(beforePay, firstPay: firstPay)


/**
假设
*/








