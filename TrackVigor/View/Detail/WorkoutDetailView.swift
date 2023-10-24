//
//  WorkoutDetailView.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/8/23.
//

import SwiftUI
import CoreData

struct WorkoutDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataController : DataController
    

   
    
    @ObservedObject var workout: Workout

    // The exercises objects are fetched from
    // within the workout object itself
    var exercises : [Exercise]{
        workout.exercise?.allObjects as? [Exercise] ?? []
    }
    
  
    
    
    // String/Array Variables
    @State var timeOfDay = String()
    @State var workoutName = String()
    @State var selectedExercise = [String]()
    
    @Binding var workoutTitle: String

    // Int Variables
    
    // Bool Variables
    @State var exerciseSheet = false
    @FocusState var isEditing: Bool
    // Model Variables
    @State var exerciseList = ExerciseModelList.allExercise
    
    
    let currentTime = Date()
    let calendar = Calendar.current
    
    
    //Timer Variables
    @State var isTimerRunning = false
    @State private var startTime =  Date()
//  @State private var timerString = "0.00"
    @State var timeElapsed: Int = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            ScrollView{
                // Header View
                HeaderView()
                // Exercises List
                ExercisesListView()
                // Buttons
             
            }
   
        }
//        .navigationTitle("\(workoutTitle)")
    }
    
    @ViewBuilder
    func HeaderView() -> some View{
    
        HStack{
            
            TextField("", text: $workoutTitle)
                .font(.title.bold())
                .lineLimit(1)
            

            Spacer()
            
            Button{
                exerciseSheet.toggle()
            }label: {
                HStack{
                    //Text("Exercise")
                    Image(systemName: "plus")

                }
                .padding()
                .frame(width: 30, height: 30)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.trailing, 15)
            .sheet(isPresented: $exerciseSheet, onDismiss: {
                print("Dismissed")
            }){
                ExerciseSheet(selectedExercise: $selectedExercise)
            }
            .onChange(of: selectedExercise){ value in
                let exercise = Exercise(context: dataController.container.viewContext)

                for name in value {
                    exercise.name = name
                }

                dataController.save()
                print("Valueee", value)
            }
        
            
            
        }
//            .padding(.top, 30)
            .padding(.horizontal, 15)
//            .frame(maxWidth: .infinity, alignment: .leading)
    }

    
    @ViewBuilder
    func ExercisesListView() -> some View{
        VStack{
            ForEach(exercises){ exercise in
                VStack(alignment: .leading, spacing: 15){
                    HStack{
                        Text(exercise.name ?? "")
                            .font(.headline)
                            .padding(.top, 30)

                        Spacer()

                        Button{

                        } label: {
                            HStack{
                                Text("Add Set")
                                Image(systemName: "plus")
                            }
                        }
                        .padding(.top, 30)
                        .padding(.trailing, 15)

                    }
                        
                        VStack{
                            
//                            HStack(alignment: .center, spacing: 25){
//                                VStack(spacing: 15){
//                                    Text("Set")
//                                        .font(.subheadline)
//
//                                    ForEach(exercise.addSet?.allObjects as? [AddSet] ?? []){ item in
//                                        TextField(item.set ?? "", text: .constant(""))
//                                            .padding(6)
//                                            .keyboardType(.numberPad)
//                                            .frame(width: 50, height: 25)
//                                            .background(
//                                                RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                            )
//                                    }
//                                }
//
//                                VStack(spacing: 15){
//                                    Text("lbs")
//                                        .font(.subheadline)
//
//                                    ForEach(exercise.addSet?.allObjects as? [AddSet] ?? []){ item in
//                                        TextField(item.lbs ?? "", text: .constant(""))
//                                            .padding(6)
//                                            .keyboardType(.numberPad)
//                                            .frame(width: 50, height: 25)
//                                            .background(
//                                                RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                            )
//                                    }
//
//
//                                }
//
//
//                                VStack(spacing: 15){
//                                    Text("Reps")
//                                        .font(.subheadline)
//
//                                    TextField("", text: .constant(""))
//                                        .padding(6)
//                                        .keyboardType(.numberPad)
//                                        .frame(width: 50, height: 25)
//                                        .background(
//                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                        )
//                                }
//
//                                Spacer()
//
//                                // Rest Timer Button
//                                Button{
//
//                                } label: {
//                                    Image(systemName: "clock")
//                                        .imageScale(.medium)
//                                }
//                                .frame(width: 25, height: 25)
//                                .background{
//                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                        .fill(Color.gray.opacity(0.1))
//                                }
//
//                                // Edit Exercise Button
//                                Button{
//                                    //                                dataController.delete(exercise)
//                                    //                                dataController.save()
//                                } label: {
//                                    Image(systemName: "trash")
//                                        .imageScale(.medium)
//                                }
//                                .frame(width: 25, height: 25)
//                                .background{
//                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                        .fill(Color.gray.opacity(0.1))
//                                }
//                            }
                            HStack(spacing: 40){
                                Text("Set")
                                    .font(.subheadline)
                                
                                Text("lbs")
                                    .font(.subheadline)
                                
                                Text("Reps")
                                    .font(.subheadline)
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(exercise.addSet?.allObjects as? [AddSet] ?? []){ item in
                                let ternaryForBackground = item.set! != "" && item.lbs! != "" && item.reps! != ""
                                HStack{
                                    TextField(item.set ?? "", text: .constant(""))
                                        .padding(6)
                                        .keyboardType(.numberPad)
                                        .frame(width: 50, height: 25)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                    
                                    TextField(item.lbs ?? "", text: .constant(""))
                                        .padding(6)
                                        .keyboardType(.numberPad)
                                        .frame(width: 50, height: 25)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                    
                                    TextField(item.reps ?? "", text: .constant(""))
                                        .padding(6)
                                        .keyboardType(.numberPad)
                                        .frame(width: 50, height: 25)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                }
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(ternaryForBackground ? Color.green.opacity(0.3) : .clear)
                            }
                            
                        
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3) ,radius: 5, x: 0 , y: 2)
                   
                }
            }
        }
        .padding(15)
    }
}

//struct WorkoutDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutDetailView()
//    }
//}
