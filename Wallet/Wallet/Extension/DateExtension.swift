//
//  DateExtension.swift
//  RayboWallet
//
//  Created by Maynard on 2018/1/18.
//  Copyright © 2018年 Maynard. All rights reserved.
//

import Foundation

extension Date {
    func isSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    func isSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    
    var formatterString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .short
            //            let locale = Locale.current
            
            let dateStr = dateFormatter.string(from: self)
            return dateStr
            
        }
    }
}
