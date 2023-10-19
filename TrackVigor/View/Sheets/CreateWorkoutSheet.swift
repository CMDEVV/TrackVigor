//
//  CreateWorkoutSheet.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/8/23.
//

import SwiftUI
import CoreData

struct CreateWorkoutSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataController : DataController
    
    // CoreData Variables
    let exercise: FetchRequest<Exercise>
    
    init(){
        exercise = FetchRequest<Exercise>(entity: Exercise.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.name, ascending: false)])
    }
    
    // String/Array Variables
    @State var timeOfDay = String()
    @State var workoutName = String()
    @State var selectedExercise = [String]()

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
                ExerciseButton()
                
        }
            .navigationTitle("Workout")
            .onAppear{
                getTimeOfDay()

            }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
    
    func getTimeOfDay() {
        let hour = calendar.component(.hour, from: currentTime)
        
        switch hour {
               case 0..<6:
                   timeOfDay = "Night Workout"
               case 6..<12:
                   timeOfDay = "Morning Workout"
               case 12..<17:
                   timeOfDay = "Afternoon Workout"
               case 17..<20:
                   timeOfDay = "Evening Workout"
               default:
                   timeOfDay = "Night Workout"
               }
        
        workoutName = timeOfDay
    }
    
    @ViewBuilder
    func HeaderView() -> some View{
    
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    
                    TextField("", text: $workoutName)
                        .font(.title.bold())
//                        .placeholder(when: workoutName.isEmpty){
//                            Text("\(timeOfDay) workout")
//                                .foregroundColor(Color.black)
//                                .font(.title)
//                        }
                       
   
                    
                    Text("\(timeElapsed) sec")
                        .font(Font.system(.headline, design: .monospaced))
                        .onReceive(timer) { firedDate in
                            if self.isTimerRunning {
                                timeElapsed = Int(firedDate.timeIntervalSince(startTime))
                                //timerString = String(format: "%.2f", (Date().timeIntervalSince( self.startTime)))
                            }
                        }
                        .onTapGesture {
                            if isTimerRunning {
                                // stop UI updates
                                self.stopTimer()
                            } else {
                                //timerString = "0.00"
                                timeElapsed = 0
                                startTime = Date()
                                // start UI updates
                                self.startTimer()
                            }
                            isTimerRunning.toggle()
                        }
                    
                }
                
                Spacer()
                
          
                    Button{
                        exerciseSheet.toggle()
                    }label: {
                        HStack{
                           
//                                Text("Exercise")
                                Image(systemName: "plus")
                            
                        }
                        .padding()
                        .frame(width: 125, height: 30)
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
                    
//                    .sheet(isPresented: $exerciseSheet){
//                        ExerciseSheet()
//                    }
                
                
            }
            .padding(.top, 30)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func ExercisesListView() -> some View{
        VStack{
            ForEach(exercise.wrappedValue){ exercise in
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
                        HStack(alignment: .center, spacing: 25){
                            VStack(spacing: 15){
                                Text("Set")
                                    .font(.subheadline)
                                
                                TextField("", text: .constant(""))
                                    .padding(6)
                                    .keyboardType(.numberPad)
                                    .frame(width: 50, height: 25)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            
                            VStack(spacing: 15){
                                Text("lbs")
                                    .font(.subheadline)
                                
                                TextField("", text: .constant(""))
                                    .padding(6)
                                    .keyboardType(.numberPad)
                                    .frame(width: 50, height: 25)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            
                            
                            VStack(spacing: 15){
                                Text("Reps")
                                    .font(.subheadline)
                                
                                TextField("", text: .constant(""))
                                    .padding(6)
                                    .keyboardType(.numberPad)
                                    .frame(width: 50, height: 25)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            
                            Spacer()
                            
                            // Rest Timer Button
                            Button{
                                
                            } label: {
                                Image(systemName: "clock")
                                    .imageScale(.medium)
                            }
                            .frame(width: 25, height: 25)
                            .background{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.gray.opacity(0.1))
                            }
                            
                            // Edit Exercise Button
                            Button{
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .imageScale(.medium)
                            }
                            .frame(width: 25, height: 25)
                            .background{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.gray.opacity(0.1))
                            }
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
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
    
    @ViewBuilder
    func ExerciseButton() -> some View{
        HStack{
            Button{
               // Cancel Workout Dimiss
               // End timer
                dismiss()
            }label: {
                Text("Cancel")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            }
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            
            Button{
               // Create Workout
                let getCurrentDate = Date()
                let format = getCurrentDate.getFormattedDate(format: "MM-dd-yyyy")
                print("CurentDate", format)
                
            }label: {
                Text("Finish")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                
            }
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding(15)
    }
  
}

//struct CreateWorkoutSheet_Previews: PreviewProvider {
//
//    static var previews: some View {
//        CreateWorkoutSheet()
//    }
//}
