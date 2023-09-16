//
//  HomeViewModel.swift
//  GTCalendar
//
//  Created by Gaurav Tak on 16/09/23.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol: ObservableObject {
    var moveToNextViewType: MoveToNextViewTypeFromHomeView { get set }
    var showNextUIOfNavigationFlow: Bool { get set }
}

enum MoveToNextViewTypeFromHomeView {
    case moveToSingleDateSelectionView
    case moveToDateRangeSelectionView
    case moveToDateRangeViewWithPastDates
    case moveToDateRangeViewWithFutureDates
}

class HomeViewModel: HomeViewModelProtocol {
    @Published var moveToNextViewType: MoveToNextViewTypeFromHomeView = .moveToSingleDateSelectionView
    @Published var showNextUIOfNavigationFlow: Bool = false
}
