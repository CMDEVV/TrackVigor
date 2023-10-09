//
//  WorkoutDetailView.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/8/23.
//

import SwiftUI

struct WorkoutDetailView: View {
    var body: some View {
        ScrollView{
            VStack{
                // WorkoutList
                WorkoutListView()
                
            }
            .padding(15)
        }
    }
    
    @ViewBuilder
    func WorkoutListView() -> some View{
        VStack{
            
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView()
    }
}
