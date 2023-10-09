//
//  History.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import SwiftUI

struct HistoryView: View {
    
    // string/array variables
        
    // Int Variables
    
    // Bool Variables
    
    // Model Variables
    @State var workoutModel = WorkoutModelList.allWorkouts
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    WorkoutList()
                }
                .navigationTitle("History")
                .padding(15)
            }
        }
    }
    
    @ViewBuilder
    func WorkoutList() -> some View {
        VStack{
            ForEach(workoutModel, id: \.id){ workout in
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text(workout.name)
                            .font(.headline)
                        
                        Spacer()
                        HStack{
                            Image(systemName: "clock")
                                .imageScale(.medium)
                            
                            Text("\(workout.timer)min")
                                .font(.headline)
                        }
                    }
                    
                    Text(workout.date)
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 85)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            }
            
        }
    }

}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
