//
//  HomeView.swift
//  GTCalendar
//
//  Created by Gaurav Tak LLP on 16/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    func buildView() -> some View {
        if viewModel.moveToNextViewType == .moveToSingleDateSelectionView {
            return AnyView(GTCalendarView(viewModel: GTCalendarViewModel(titleOfUi: "Single Date Selection", isOnlySingleDateSelectionAllowed: true, actionDaysCountAndStartEndDate: {
                days, startDate, endDate in
                print("actionDaysCountAndStartEndDate days \(days) startDate \(startDate) endDate \(endDate)")
            }))).edgesIgnoringSafeArea(.all)
        } else if viewModel.moveToNextViewType == .moveToDateRangeSelectionView {
            return AnyView(GTCalendarView(viewModel: GTCalendarViewModel(titleOfUi:"Date Range Selection", actionDaysCountAndStartEndDate: {
                days, startDate, endDate in
                print("actionDaysCountAndStartEndDate days \(days) startDate \(startDate) endDate \(endDate)")
            }))).edgesIgnoringSafeArea(.all)
        } else if viewModel.moveToNextViewType == .moveToDateRangeViewWithPastDates {
            return AnyView(GTCalendarView(viewModel: GTCalendarViewModel(titleOfUi: "Date Range Selection With Past Dates", isPreviousDatesDisabled: false, isNextDatesDisabled: true,
                actionDaysCountAndStartEndDate: {
                days, startDate, endDate in
                print("actionDaysCountAndStartEndDate days \(days) startDate \(startDate) endDate \(endDate)")
            }))).edgesIgnoringSafeArea(.all)
        } else if viewModel.moveToNextViewType == .moveToDateRangeViewWithFutureDates {
            return AnyView(GTCalendarView(viewModel: GTCalendarViewModel(titleOfUi: "Date Range Selection With Future Dates", isPreviousDatesDisabled: true, isNextDatesDisabled: false, actionDaysCountAndStartEndDate: {
                days, startDate, endDate in
                print("actionDaysCountAndStartEndDate days \(days) startDate \(startDate) endDate \(endDate)")
            }))).edgesIgnoringSafeArea(.all)
        } else {
            return AnyView(HomeView()).edgesIgnoringSafeArea(.all)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                NavigationLink(
                    destination: buildView(), isActive: $viewModel.showNextUIOfNavigationFlow
                ) {
                    EmptyView()
                }.isDetailLink(false)
                
                Image("calendar")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                Text("Integration of Custom Calendar View with SwiftUI").padding(.top, 10).padding(.bottom, 30)
                Button {
                    print("Tap me to Launch Single Date Selection View")
                    viewModel.moveToNextViewType = .moveToSingleDateSelectionView
                    viewModel.showNextUIOfNavigationFlow = true
                } label: {
                    Text("Tap me to Launch Single Date Selection View").underline()
                }.padding(.vertical, 10)
                
                Button {
                    print("Tap me to Launch Date Range Selection View")
                    viewModel.moveToNextViewType = .moveToDateRangeSelectionView
                    viewModel.showNextUIOfNavigationFlow = true
                } label: {
                    Text("Tap me to Launch Date Range Selection View").underline()
                }.padding(.vertical, 10)
                Button {
                    print("Tap me to Launch Date Range View With Past Dates")
                    viewModel.moveToNextViewType = .moveToDateRangeViewWithPastDates
                    viewModel.showNextUIOfNavigationFlow = true
                } label: {
                    Text("Tap me to Launch Date Range View With PastDates").underline()
                }.padding(.vertical, 10)
                Button {
                    print("Tap me to Launch Date Range View With Future Dates")
                    viewModel.moveToNextViewType = .moveToDateRangeViewWithFutureDates
                    viewModel.showNextUIOfNavigationFlow = true
                } label: {
                    Text("Tap me to Launch Date Range View With FutureDates").underline()
                }.padding(.vertical, 10)
            }
        }.padding(.all, 16)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
