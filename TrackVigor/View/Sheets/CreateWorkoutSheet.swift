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
    @Environment(\.managedObjectContext) var moc

    @EnvironmentObject var dataController : DataController
    
//    let workout: Workout
//
//    var exercise : [Exercise] {
//        workout.exercise?.allObjects as? [Exercise] ?? []
//    }
    // CoreData Variables
//    let exercise: FetchRequest<Exercise>
//    let workout: Workout
//    let exericses: [Exercise]
    
//    init(workout: Workout){
//        self.workout = workout
//
//    }
    
//    init(){
//        exercise = FetchRequest<Exercise>(entity: Exercise.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.name, ascending: false)])
//    }
    
    // String/Array Variables
    @State var timeOfDay = String()
    @State var workoutName = String()
    @State var selectedExercise = [String]()
    
    @State var setText = String()
    @State var lbsText = String()
    @State var repText = String()

    // Int Variables
    
    // Bool Variables
    @State var exerciseSheet = false
    @FocusState var isEditing: Bool
    // Model Variables
    @State var workoutModel = [WorkoutModel]()
    @State var currentExercise: ExericiseModel?
//    @State var exerciseList = ExerciseModelList.allExercise
    
    
    let currentTime = Date()
    let calendar = Calendar.current
    
    
    //Timer Variables
    @State var isTimerRunning = false
    @State private var startTime =  Date()
//  @State private var timerString = "0.00"
    @State var timeElapsed: Int = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    

    @State private var newSetLbs: String = ""
    @State private var newSetReps: String = ""
    @State private var newSetDesc: String = ""
    
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
                } label: {
                    HStack{
                        //Text("Exercise")
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
                    let getCurrentDate = Date()
                    let formatDate = getCurrentDate.getFormattedDate(format: "MM-dd-yyyy")
                    
                    var modelOne = WorkoutModel(name: workoutName, creationDate: formatDate, exercises: [])
                    for exercise in value{
                        let modelTwo = ExericiseModel(name: exercise, addSet: [AddSetModel(lbs: "", reps: "", set: "")])
                        modelOne.exercises.append(modelTwo)
                    }
                    
                    workoutModel.append(modelOne)
                    print("workoutMOdell", workoutModel)
                    
                }

            }
            .padding(.top, 30)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func addSetToSelectedExercise() {
        if var exercise = currentExercise {
            // Append a new set to the selected exercise's addSet array
            exercise.addSet.append(AddSetModel(lbs: "", reps: "", set: ""))
            // exercise.addSet.append(AddSetModel(lbs: "", reps: "", set: ""))
            currentExercise = exercise
        }
    }
    
    
    @ViewBuilder
    func ExercisesListView() -> some View{
        VStack{
            ForEach($workoutModel, id: \.id){ workout in
                ForEach(workout.exercises, id: \.id){ exercise in
                    
                    VStack(alignment: .leading, spacing: 15){
                        HStack{
                            
                            Text(exercise.wrappedValue.name)
                                .font(.headline)
                                .padding(.top, 30)
                            
                            Spacer()
                            
                            Button{
                                
//                                if var exercise = currentExercise{
//                                    exercise.addSet.append(AddSetModel(lbs: "", reps: "", set: ""))
//                                }
                                
//                                var createNewsSet = AddSetModel(lbs: "", reps: "", set: "")
//                                exercise.addSet = createNewsSet
                                
//                           print("NewSett", exercise)
//                           currentExercise = exercise
//                           addSetToSelectedExercise()
//                           exercise.addSet.append(AddSetModel(lbs: T##String, reps: T##String, set: T##String))
//                           exercise.addSet(AddSetModel(lbs: "", reps: "", set: ""))
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
                            HStack(spacing: 40){
                                Text("Set")
                                    .font(.subheadline)
                                
                                Text("lbs")
                                    .font(.subheadline)
                                
                                Text("Reps")
                                    .font(.subheadline)
                                
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
//                                    dataController.delete(exercise)
//                                    dataController.save()
                                } label: {
                                    Image(systemName: "trash")
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(exercise.wrappedValue.addSet, id: \.id){ item in
                                HStack{
                                    TextField(item.set , text: .constant(""))
                                        .padding(6)
                                        .keyboardType(.numberPad)
                                        .frame(width: 50, height: 25)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                    
                                    TextField(item.lbs, text: .constant(""))
                                        .padding(6)
                                        .keyboardType(.numberPad)
                                        .frame(width: 50, height: 25)
                                        .background(
                                          RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                    
                                    TextField(item.reps, text: .constant(""))
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
//                              .background(ternaryForBackground ? Color.green.opacity(0.3) : .clear)
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
//              print("CurentDate", format)
                
                let workout = Workout(context: dataController.container.viewContext)
                workout.name = workoutName
                workout.creationDate = format
                
                
//              workout.exercise = self.exercise
//                for i in exercise.wrappedValue{
//                    workout.exercise?.name = i.name
//                }
                
                dataController.save()
                
                dismiss()
                
            } label: {
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
