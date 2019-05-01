//
//  dateDataProvider.swift
//  UniversityApp
//
//  Created by Роман Макеев on 30.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import Foundation


class dateDataProvider {
    
    var total = 0
    var today = [Int]()
    var daysInMonth = [Int]()
    
    
    func getDate(){
        let gregorianCalendar = Calendar(identifier: .gregorian)
        let date = Date()
        let calendar = Calendar.current
        today.append(calendar.component(.month, from: date))
        today.append(calendar.component(.day, from: date))
        let range = calendar.range(of: .day, in: .year, for: date)
        total = (range?.count)!
        
        for month in 1...12 {
            let dateComponents = DateComponents(calendar: gregorianCalendar, year: 2018, month: month, day: 1)
            let dated = gregorianCalendar.date(from: dateComponents)
            let range = gregorianCalendar.range(of: .day, in: .month, for: dated!)
            daysInMonth.append((range?.count)!)
        }
        print("month \(today[0]) day \(today[1]) \n \(daysInMonth)" )
        
       // let dateComponents = DateComponents(calendar: gregorianCalendar, year: 2018, month: month, day: day)
        //let dated = gregorianCalendar.date(from: dateComponents)
    }
    
    func getWeek( month: Int, day: Int) -> String {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(calendar: gregorianCalendar, year: 2018, month: month, day: day)
        let dated = gregorianCalendar.date(from: dateComponents)
        let weekDay = gregorianCalendar.component(.weekday, from: dated!)
        switch weekDay {
        case 1:
            return "вс"
        case 2:
            return "пн"
        case 3:
            return "вт"
        case 4:
            return "ср"
        case 5:
            return "чт"
        case 6:
            return "пт"
        case 7:
            return "сб"
        default:
            print("WEEEEEKK")
            return "n"
        }
        
        
    }
    
/*
     let gregorianCalendar = Calendar(identifier: .gregorian)
     let dateComponents = DateComponents(calendar: gregorianCalendar, year: 2018, month: month, day: day)
     let dated = gregorianCalendar.date(from: dateComponents)
     print("weekDay \(gregorianCalendar.component(.weekday, from: dated!))")
     
     let range = gregorianCalendar.range(of: .day, in: .year, for: dated!)
     
     
     weekDay = gregorianCalendar.component(.weekday, from: dated!)
 */
}
