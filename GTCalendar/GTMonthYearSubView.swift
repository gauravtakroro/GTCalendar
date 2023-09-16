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
                    Image("left").resizable()
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .padding(.leading, 10)
                .opacity(viewModel.isPreviousMonthDisabled ? 0.3 : 1.0)
                .disabled(viewModel.isPreviousMonthDisabled)
                    .buttonStyle(.plain)
                
                Text(viewModel.titleForMonth())
                    .font(viewModel.fontStyleForMonth)
                    .foregroundColor(viewModel.fontColorForMonth)
                    .frame(width: 100)
                Button(action: {
                    viewModel.selectForwardMonth()
                }) {
                    Image("right").resizable()
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 10)
                .opacity(viewModel.isNextMonthDisabled ? 0.3 : 1.0)
                .disabled(viewModel.isNextMonthDisabled)
                    .buttonStyle(.plain)
            }
            
            HStack {
                Button(action: {
                    viewModel.selectBackYear()
                }) {
                    Image("left").resizable()
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .padding(.leading, 10)
                .opacity(viewModel.isPreviousYearDisabled ? 0.3 : 1.0)
                .disabled(viewModel.isPreviousYearDisabled)
                    .buttonStyle(.plain)
                
                Text(viewModel.titleForYear())
                    .font(viewModel.fontStyleForYear)
                    .foregroundColor(viewModel.fontColorForYear)
                   
                    .frame(width: 45)
                Button(action: {
                    viewModel.selectForwardYear()
                }) {
                    Image("right").resizable()
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 10)
                .opacity(viewModel.isNextYearDisabled ? 0.3 : 1.0)
                .disabled(viewModel.isNextYearDisabled)
                    .buttonStyle(.plain)
            }
        }
        .foregroundColor(Color.white)
        .onAppear {
            viewModel.isMatchingWithCurrentMonthYear()
            viewModel.isMatchingWithCurrentYear()
        }
    }
}
