//
//  GTDaysSelectionRangeBackgroundSubView.swift.swift
//  GTCalendar
//
//  Created by Roro Solutions LLP on 16/09/23.
//


import Foundation
import SwiftUI

struct GTDaysSelectionRangeBackgroundSubView: View {
    // MARK: - PROPERTIES
    @ObservedObject var viewModel: GTCalendarViewModel
    var day: Date
    var week: [Date]
    var index: Int
    // MARK: - BODY
    var body: some View {
        
        HStack(spacing: 0) {
            if viewModel.isDateSelected(day: day) {
                if day == viewModel.firstDate {
                    Color.clear
                } else if viewModel.isFirstDayOfMonth(date: day) || index == 0 {
                    Color.clear
                } else {
                    Color.gray
                }
            } else {
                if viewModel.isDateInRange(day: day) {
                    if index == 0 {
                        Color.clear
                    } else {
                        if viewModel.isFirstDayOfMonth(date: day) {
                            Color.clear
                        } else {
                            Color.gray
                        }
                    }
                } else {
                    Color.clear
                }
            }
            
            if viewModel.isDateSelected(day: day) {
                if day == viewModel.secondDate {
                    Color.clear
                } else {
                    if viewModel.secondDate == nil {
                        Color.clear
                    } else if viewModel.isLastDayOfMonth(date: day) || index == 6 {
                        Color.clear
                    } else {
                        Color.gray
                    }
                }
            } else {
                if viewModel.isDateInRange(day: day) {
                    if index == week.count - 1 {
                        Color.clear
                    } else {
                        if viewModel.isLastDayOfMonth(date: day) {
                            Color.clear
                        } else {
                            Color.gray
                        }
                    }
                } else {
                    Color.clear
                }
            }
        }
    }
}
