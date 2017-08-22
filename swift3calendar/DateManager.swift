//
//  DateManager.swift
//  swift3calendar
//
//  Created by 可児潤也 on 2017/08/22.
//  Copyright © 2017年 easycomeeasygo. All rights reserved.
//

import UIKit

class DateManager: NSObject {
    
    var currentMonthOfDates = [Date]() //表記する月の配列
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!
    var changedMonth: Int = 0
    
    //月ごとのセルの数を返すメソッド
    func daysAcquisition() -> Int {
        let calendar = Calendar.current
        let rangeOfWeeks = calendar.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth())
        let numberOfWeeks = rangeOfWeeks?.count //月が持つ週の数
        numberOfItems = numberOfWeeks! * daysPerWeek //週の数×列の数
        return numberOfItems
    }
    
    func firstDateOfMonth() -> Date {
        let calendar = Calendar.current
        var comps = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        comps.day = 1
        let firstday = calendar.date(from: comps)
        return firstday!
    }
    
    // ⑴表記する日にちの取得
    func dateForCellAtIndexPath(numberOfItems: Int) {
        //「月の初日が週の何日目か」を計算する
        let calendar = Calendar.current
        let ordinalityOfFirstDay = calendar.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth())!
        for i in 0 ..< numberOfItems {
            let dateComponents = DateComponents(day: i - (ordinalityOfFirstDay-1))
            let date = calendar.date(byAdding: dateComponents, to: firstDateOfMonth())!
            currentMonthOfDates.append(date)
        }
    }
    
    // ⑵表記の変更
    func conversionDateFormat(indexPath: IndexPath) -> String {
        dateForCellAtIndexPath(numberOfItems: numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row] as Date)
    }
    
    //前月の表示
    func prevMonth(date: Date) -> Date {
        changedMonth -= 1
        currentMonthOfDates = []
        selectedDate = date.changeMonthDate(changedMonth: changedMonth)
        return selectedDate
    }
    //次月の表示
    func nextMonth(date: Date) -> Date {
        changedMonth += 1
        currentMonthOfDates = []
        selectedDate = date.changeMonthDate(changedMonth: changedMonth)
        return selectedDate
    }
    
}

extension Date {
    func changeMonthDate(changedMonth: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = changedMonth
        return calendar.date(byAdding: dateComponents, to: Date())!
    }
    
}
