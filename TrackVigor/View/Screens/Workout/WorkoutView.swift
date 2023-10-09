//
//  WorkoutView.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import SwiftUI

struct WorkoutView: View {
    // String Variables
    
    // Int Variables
    
    // Bool Variables
    @State var profileSheet: Bool = false
    @State var createWorkoutSheet: Bool = false
    // Model Variables
    @State var workoutModel = WorkoutModelList.allWorkouts
    
    
    
    var body: some View {
        NavigationStack{
                ZStack{
                    ScrollView{
                    // WorkoutList
                    WorkoutList()
                }
                    // Button
                    CreateWorkoutButton()
            }
            .navigationTitle("Workout")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        profileSheet.toggle()
                    } label: {
                        Image(systemName: "person.circle")
                            .imageScale(.large)
                    }
                    .sheet(isPresented: $profileSheet){
                        ProfileSheet()
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                    }
                }
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
        .padding(15)
    }
    
    @ViewBuilder
    func CreateWorkoutButton() -> some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                
                Button{
                    // Open Sheet to create workout
                    createWorkoutSheet.toggle()
                }label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
                .frame(width: 60, height: 60)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(50)
            }
            .sheet(isPresented: $createWorkoutSheet){
                CreateWorkoutSheet()
            }
            
        }
        .padding(.vertical, 22)
        .padding(.horizontal, 15)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
    }
}
