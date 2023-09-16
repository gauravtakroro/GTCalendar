//
//  GTMonthYearSubView.swift
//  GTCalendar
//
//  Created by Gaurav Tak on 16/09/23.
//

import Foundation
import SwiftUI

struct GTMonthYearSubView: View {
    // MARK: - PROPERTIES
    @ObservedObject var viewModel: GTCalendarViewModel
    
    // MARK: - BODY
    var body: some View {
        
        
        HStack {
            HStack {
                Button(action: {
                    viewModel.selectBackMonth()
                }) {
                    Image("left")
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .padding(.leading, 10)
                Text(viewModel.titleForMonth())
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 100)
                Button(action: {
                    viewModel.selectForwardMonth()
                }) {
                    Image("right")
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 10)
            }
            
            HStack {
                Button(action: {
                    viewModel.selectBackYear()
                }) {
                    Image("left")
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .padding(.leading, 10)
                Text(viewModel.titleForYear())
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 45)
                Button(action: {
                    viewModel.selectForwardYear()
                }) {
                    Image("right")
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 10)
            }
        }
        .foregroundColor(Color.white)
        .onAppear {
            viewModel.isMatchingWithCurrentMonthYear()
        }
    }
}
