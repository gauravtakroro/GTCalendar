//
//  ContentView.swift
//  GTCalendar
//
//  Created by Gaurav Tak on 16/09/23.
//

import SwiftUI

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
