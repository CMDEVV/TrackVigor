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
        VStack(alignment: .leading){
            Text("OCTOBER 2023")
                .font(.subheadline)
            ForEach(workoutModel, id: \.id){ workout in
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text("\(workout.name)")
                            .font(.headline)
                        
                        Spacer()
                        
                        HStack{
                            // Add Clock
                            Button{
                                // Delete Item or Share
                            } label: {
                                Image(systemName: "ellipsis").imageScale(.medium)
                            }
                            .frame(width: 23, height: 23)
                            .background{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.gray.opacity(0.1))
                            }
                        }
                    }
                    
                    Text(workout.creationDate)
                    
                    VStack(alignment: .leading, spacing: 3){
                        Text("Exercise")
                            .font(.headline)
                        
                        Text("1x Bench Press")
                            .font(.subheadline)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 140)
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
