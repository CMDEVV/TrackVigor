//
//  WorkoutView.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import SwiftUI
import CoreData
import RealmSwift

struct WorkoutView: View {
    @EnvironmentObject var dataController: DataController
    let realm = try! Realm()
    
    @ObservedResults(WorkoutRealmModel.self) var workouts
    // String Variables
    @State var workoutClicked: String = ""
    // Int Variables
    
    // Bool Variables
    @State var profileSheet: Bool = false
    @State var createWorkoutSheet: Bool = false
    @State var goToDetail = false

    // Model Variables
//    @State var workoutModel = WorkoutModelList.allWorkouts
    
    // Coredata Variables
//    let workouts: FetchRequest<Workout>
//
//    
//    init(){
//        workouts = FetchRequest<Workout>(entity: Workout.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Workout.creationDate, ascending: false)])
//    }
    
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
            .onAppear{
//                for i in workouts.wrappedValue{
//                    print("data", i.exercise?.)
//                }
            }
           
//            .toolbar{
//                ToolbarItem(placement: .navigationBarTrailing){
//                    Button{
//                        profileSheet.toggle()
//                    } label: {
//                        Image(systemName: "person.circle")
//                            .imageScale(.large)
//                    }
//                    .sheet(isPresented: $profileSheet){
//                        ProfileSheet()
//                    }
//                }
//            }
        }
    }
    
    @ViewBuilder
    func WorkoutList() -> some View {
        VStack{
            if workouts.isEmpty{
                Text("No exercises found")
                    .font(.title3.bold())
            }
            
            // MARK: Should be able to fix getting the correct workout by adding NavigationLink
            ForEach(workouts, id: \.id){ workout in
                
              Button{
                    goToDetail = true
                } label: {
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Text(workout.name)
                                .font(.headline)
                            
                            Spacer()
                            HStack(spacing: 13){
                               
                                Image(systemName: "clock")
                                    .imageScale(.medium)
                                
                                Text("34 min")
                                    .font(.subheadline)
                                
                                Button{
//                                    dataController.delete(workout)
//                                    dataController.save()
                                } label: {
                                    Image(systemName: "trash")
                                        .padding()
                                        .frame(width: 23, height: 23)
                                }
                                .background{
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.gray.opacity(0.15))
                                }
                            }
                        }
                       
                        
                        Text(workout.date)
                            .font(.caption)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 85)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    .onTapGesture {
                        workoutClicked = workout.name
                        goToDetail = true
                    }
                    
                }
                .navigationDestination(isPresented: $goToDetail){
                    WorkoutDetailView(workout: workout, workoutTitle: $workoutClicked)
                }
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



