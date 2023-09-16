//
//  HomeView.swift
//  GTCalendar
//
//  Created by Gaurav Tak LLP on 16/09/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image("calendar")
                .resizable()
                .frame(width: 60, height: 60)
                
            Text("Custom Calendar Designing")
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
