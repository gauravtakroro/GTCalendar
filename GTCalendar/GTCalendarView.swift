//
//  GTCalendarView.swift
//  GTCalendar
//
//  Created by Gaurav Tak on 16/09/23.
//

import SwiftUI
import Foundation

struct GTCalendarView: View {
    // MARK: - PROPERTIES
    @StateObject var viewModel: GTCalendarViewModel
    
    // MARK: - BODY
    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    
                    GTMonthYearSubView(viewModel: viewModel)
                    
                    VStack(spacing: 3) {
                        HStack(spacing: 0) {
                            ForEach(viewModel.days, id: \.self) { day in
                                Text("\(day)")
                                    .frame(height: 36)
                                    .frame(maxWidth: .infinity)
                                    .font(viewModel.fontStyleForDays)
                            }
                        }
                        .foregroundColor(Color.black)
                        
                    }
                    
                    VStack(spacing: 6) {
                        ForEach(viewModel.weeks, id: \.self) { week in
                            ZStack {
                                HStack(spacing: 0) {
                                    ForEach(Array(week.enumerated()), id: \.offset) { index, day in
                                        if viewModel.calendar.isDate(day, equalTo: viewModel.date, toGranularity: .month) {
                                            ZStack {
                                                GTDaysSelectionRangeBackgroundSubView(viewModel: viewModel, day: day, week: week, index: index)
                                                Button(action: {
                                                    viewModel.selectDay(day)
                                                }) {
                                                    ZStack {
                                                        Text("\(viewModel.calendar.component(.day, from: day))")
                                                            .font(viewModel.fontStyleForDates)
                                                            .foregroundColor(viewModel.isDateSelected(day: day) ? Color.white : Color.black).opacity(viewModel.checkAndDisableWithCurrentDate(day: day) ? 0.3 : 1.0)
                                                        
                                                        Circle()
                                                            .frame(width: 4, height: 4)
                                                            .foregroundColor(viewModel.isToday(day: day) ? (viewModel.isDateSelected(day: day) ? viewModel.dotColorForToday : viewModel.dotColorForToday) : Color.clear)
                                                            .offset(y: 12)
                                                    }
                                                    .frame(width: 40, height: 40)
                                                    .contentShape(Rectangle())
                                                }
                                                .disabled(viewModel.checkAndDisableWithCurrentDate(day: day) || !viewModel.calendar.isDate(day, equalTo: viewModel.date, toGranularity: .month))
                                                .buttonStyle(.plain)
                                                .background(viewModel.checkValuesAndUpdateColor(day: day))
                                                .cornerRadius(viewModel.getRadiusValueUsingDayAndIndex(day: day, index: index))
                                            }
                                            .frame(height: 40)
                                            .frame(maxWidth: .infinity)
                                        } else {
                                            Text("\(viewModel.calendar.component(.day, from: day))")
                                                .font(viewModel.fontStyleForDates)
                                                .foregroundColor(viewModel.fontColorForDates)
                                                .opacity(0.3)
                                                .frame(height: 40).frame(maxWidth: .infinity)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.titleOfUi)
    }
}

// MARK: - PREVIEW
struct GTCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        GTCalendarView(viewModel: GTCalendarViewModel(actionDaysCountAndStartEndDate: { days, start, end in
            
        }))
    }
}



