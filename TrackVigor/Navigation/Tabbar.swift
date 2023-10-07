//
//  Tabbar.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        TabView{
            WorkoutView()
                .tabItem{
                    Label("Workout", systemImage: "dumbbell")
                }
            
            HistoryView()
                .tabItem{
                    Label("History", systemImage: "clock")
                }
            
            StatisticsView()
                .tabItem{
                    Label("Statistics", systemImage: "chart.bar")
                }
        }
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
    }
}
