//
//  GTCalendarViewModel.swift
//  GTCalendar
//
//  Created by Gaurav Tak on 16/09/23.
//

import SwiftUI
import Foundation

class GTCalendarViewModel: ObservableObject {
    
    var isOnlySingleDateSelectionAllowed: Bool = false
    var titleOfUi: String = "Calendar View"
    
    var isPreviousDatesDisabled: Bool = false
    var isNextDatesDisabled: Bool = false
    
    @Published var isPreviousMonthDisabled: Bool = false
    @Published var isNextMonthDisabled: Bool = false
    
    @Published var isPreviousYearDisabled: Bool = false
    @Published var isNextYearDisabled: Bool = false
   
    var calendar = Calendar.current
    var actionDaysCountAndStartEndDate: ((Int, String, String) -> Void)?
    
    @Published var date = Date()
    
    @Published var firstDate: Date?
    @Published var secondDate: Date?
    var fontStyleForMonth: Font = .system(size: 16, weight: .semibold)
    var fontColorForMonth: Color = Color.black
    var fontStyleForYear: Font = .system(size: 16, weight: .semibold)
    var fontColorForYear: Color = Color.black
    var fontStyleForDays: Font = .system(size: 12, weight: .semibold)
    var fontColorForDays: Color = Color.black
    var fontStyleForDates: Font = .system(size: 14, weight: .semibold)
    var fontColorForDates: Color = Color.black
    var dotColorForToday: Color = Color.green
    var selectionCircleColorForStartEndDate: Color = Color.blue
    var selectionCircleRadiusForStartEndAndRangeDates: Double = 20.0
    
    var selectionCircleColorForBetweenDate: Color = Color.gray
    
    var opacityOfDisabledDates: Double = 0.3
    
    let dateFormatString = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let dateFormatterGet = DateFormatter()
    var weeks: [[Date]] {
        calendar.firstWeekday = 1
        var weeks = [[Date]]()
        let range = self.calendar.range(of: .weekOfYear, in: .month, for: date)!
        for week in range {
            var weekDays = [Date]()
            for day in 0...6 {
                let date = calendar.date(byAdding: .day, value: day, to: date.startOfMonth(calendar).startOfWeek(week, calendar: calendar))!
                weekDays.append(date)
            }
            weeks.append(weekDays)
        }
        return weeks
    }
    
    var days: [String] {
        ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    }
    
    var selectedDateRange: ClosedRange<Date>? {
        if let firstDate = firstDate, let secondDate = secondDate {
            return firstDate...secondDate
        }
        return nil
    }
    
    init(_ currentDate: Date = Date(), titleOfUi: String = "Calendar View", isOnlySingleDateSelectionAllowed: Bool = false, isPreviousDatesDisabled: Bool = false, isNextDatesDisabled: Bool = false, actionDaysCountAndStartEndDate: ((Int, String, String) -> Void)?) {
        date = currentDate
        self.titleOfUi = titleOfUi
        self.actionDaysCountAndStartEndDate = actionDaysCountAndStartEndDate
        self.isOnlySingleDateSelectionAllowed = isOnlySingleDateSelectionAllowed
        self.isPreviousDatesDisabled = isPreviousDatesDisabled
        self.isNextDatesDisabled = isNextDatesDisabled
        dateFormatterGet.dateFormat = dateFormatString
    }
    
    func selectDay(_ day: Date) {
        if isOnlySingleDateSelectionAllowed {
            DispatchQueue.main.async {
                self.firstDate = day
                self.secondDate = day
                if let actionResult = self.actionDaysCountAndStartEndDate {
                    actionResult(1, self.dateFormatterGet.string(from: self.firstDate!), self.dateFormatterGet.string(from: self.secondDate!))
                }
            }
            return
        }
         if firstDate == nil {
            DispatchQueue.main.async {
                self.firstDate = day
            }
        } else if secondDate == nil {
            if let first = firstDate {
                if first > day {
                    DispatchQueue.main.async {
                        self.secondDate = first
                        self.firstDate = day
                    }
                } else {
                    DispatchQueue.main.async {
                        self.secondDate = day
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.firstDate = day
                self.secondDate = nil
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            if self.firstDate == nil || self.secondDate == nil {
                if let actionResult = self.actionDaysCountAndStartEndDate {
                    
                    if self.firstDate == nil && self.secondDate != nil {
                        actionResult(1, self.dateFormatterGet.string(from: self.secondDate!), self.dateFormatterGet.string(from: self.secondDate!))
                    } else if self.secondDate == nil && self.firstDate != nil {
                        actionResult(1, self.dateFormatterGet.string(from: self.firstDate!), self.dateFormatterGet.string(from: self.firstDate!))
                    }
                    
                }
            } else {
                let diffInDays = Calendar.current.dateComponents([.day], from: self.firstDate!, to: self.secondDate!).day!
                if let actionResult = self.actionDaysCountAndStartEndDate {
                    actionResult(diffInDays + 1, self.dateFormatterGet.string(from: self.firstDate!), self.dateFormatterGet.string(from: self.secondDate!))
                }
            }
        })
        
    }
    
    func isToday(day: Date) -> Bool {
        return calendar.isDateInToday(day)
    }
    
    func isDateInRange(day: Date) -> Bool {
        if secondDate == nil {
            if let firstDate {
                return firstDate == day
            }
        } else {
            if let firstDate = firstDate, let secondDate = secondDate {
                return day >= firstDate && day <= secondDate
            }
        }
        return false
    }
    
    func isDateSelected(day: Date) -> Bool {
        if secondDate == nil {
            if let firstDate {
                return firstDate == day
            }
        } else {
            if let firstDate, let secondDate {
                return ((firstDate == day) || (secondDate == day))
            }
        }
        return false
    }
    
    func isFirstDayOfMonth(date: Date) -> Bool {
        let components = calendar.dateComponents([.day], from: date)
        return components.day == 1
    }
    
    func isLastDayOfMonth(date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        let lastDayOfMonth = calendar.range(of: .day, in: .month, for: date)!.upperBound - 1
        return components.day == lastDayOfMonth
    }
    
    func dateToStr(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func titleForMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date).uppercased()
    }
    
    func titleForYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    
    func selectBackMonth() {
        self.date = self.calendar.date(byAdding: .month, value: -1, to: self.date) ?? Date()
        self.isMatchingWithCurrentMonthYear()
        self.isMatchingWithCurrentYear()
    }
    
    func selectForwardMonth() {
        self.date = self.calendar.date(byAdding: .month, value: 1, to: self.date) ?? Date()
        self.isMatchingWithCurrentMonthYear()
        self.isMatchingWithCurrentYear()
    }
    
    func selectBackYear() {
        self.date = self.calendar.date(byAdding: .year, value: -1, to: self.date) ?? Date()
        self.isMatchingWithCurrentMonthYear()
        self.isMatchingWithCurrentYear()
    }
    
    func selectForwardYear() {
        self.date = self.calendar.date(byAdding: .year, value: 1, to: self.date) ?? Date()
        self.isMatchingWithCurrentMonthYear()
        self.isMatchingWithCurrentYear()
    }
    
    func isMatchingWithCurrentMonthYear() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        
        let monthYearSelected = dateFormatter.string(from: date)
        
        let monthYearCurrent = dateFormatter.string(from: Date())
        
        DispatchQueue.main.async {
            if self.isPreviousDatesDisabled {
                self.isPreviousMonthDisabled = monthYearSelected <= monthYearCurrent
            } else {
                self.isPreviousMonthDisabled = false
            }
        }
        DispatchQueue.main.async {
            if self.isNextDatesDisabled {
                self.isNextMonthDisabled = monthYearSelected >= monthYearCurrent
            } else {
                self.isNextMonthDisabled = false
            }
        }
        print("isMatchingWithCurrentMonthYear \(self.isPreviousMonthDisabled) \(self.isNextMonthDisabled) \(monthYearSelected) \(monthYearCurrent) \(monthYearSelected <= monthYearCurrent) \(monthYearSelected >= monthYearCurrent)")
    }
    
    func isMatchingWithCurrentYear() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        let yearSelected = dateFormatter.string(from: date)
        
        let yearCurrent = dateFormatter.string(from: Date())
        DispatchQueue.main.async {
            if self.isPreviousDatesDisabled {
                self.isPreviousYearDisabled = yearSelected <= yearCurrent
            } else {
                self.isPreviousYearDisabled = false
            }
        }
        DispatchQueue.main.async {
            if self.isNextDatesDisabled {
                self.isNextYearDisabled = yearSelected >= yearCurrent
            } else {
                self.isNextYearDisabled = false
            }
        }
        print("isMatchingWithCurrentYear \(self.isPreviousYearDisabled) \(self.isNextYearDisabled) \(yearSelected) \(yearCurrent) \(yearSelected <= yearCurrent) \(yearSelected >= yearCurrent)")
    }
    
    func isMatchingWithSelectedFirstDateMonthYear() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        let monthYearSelected = dateFormatter.string(from: date)
        let monthYearFirstDate = dateFormatter.string(from: firstDate ?? Date())
        return monthYearSelected == monthYearFirstDate
    }
    
    func isLessThanWithCurrentDate(day: Date) -> Bool {
        if isToday(day: day) {
            return false
        } else {
            return day < Date()
        }
    }
    
    func checkAndDisableWithCurrentDate(day: Date) -> Bool {
        if isToday(day: day) {
            return false
        } else {
            if isPreviousDatesDisabled {
                return day < Date()
            } else if isNextDatesDisabled {
                return day > Date()
            } else {
                return day < Date()
            }
        }
    }
    
    func checkValuesAndUpdateColor(day: Date) -> Color {
        return isDateInRange(day: day) ? (isDateSelected(day: day) ? selectionCircleColorForStartEndDate: selectionCircleColorForBetweenDate) : Color.clear
    }
    
    func getRadiusValueUsingDayAndIndex(day: Date, index: Int) -> Double {
        return isDateSelected(day: day) ? selectionCircleRadiusForStartEndAndRangeDates : (isDateInRange(day: day) ? selectionCircleRadiusForStartEndAndRangeDates : 0.0)
    }
    
    func getRoundedCornersUsingDayAndIndex(day: Date, index: Int) -> UIRectCorner {
        if isDateSelected(day: day) {
            return [.topLeft, .bottomRight, .topRight, .bottomLeft]
        } else if index == 0 && isDateInRange(day: day) {
            return [.topLeft, .bottomLeft]
        } else if index == 6 && isDateInRange(day: day) {
            return [.topRight, .bottomRight]
        }
        return [.allCorners]
    }
    
}

extension Date {
    func startOfMonth(_ calendar: Calendar) -> Date {
        return calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: self)))!
    }
    
    func startOfWeek(_ week: Int, calendar: Calendar) -> Date {
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.weekOfYear = week
        components.weekday = calendar.firstWeekday
        return calendar.date(from: components)!
    }
}


