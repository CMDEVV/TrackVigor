//
//  CreateWorkoutSheet.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/8/23.
//

import SwiftUI

struct CreateWorkoutSheet: View {
    // String/Array Variables
    @State var isTimerRunning = false
    @State private var startTime =  Date()
//    @State private var timerString = "0.00"
    @State var timeElapsed: Int = 0

    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // Int Variables
    
    // Bool Variables
    @State var exerciseSheet: Bool = false
    
    // Model Variables
    @State var exerciseList = ExerciseModelList.allExercise
    
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
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
    
    @ViewBuilder
    func HeaderView() -> some View{
    
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text("Workout")
                        .font(.title.bold())
                    
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
                            Text("Exercise")
                            Image(systemName: "plus")
                        }
                        .padding()
                        .frame(width: 125, height: 30)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.trailing, 15)
                    .sheet(isPresented: $exerciseSheet){
                        ExerciseSheet()
                    }
                
                
            }
            .padding(.top, 30)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func ExercisesListView() -> some View{
        VStack{
            ForEach(exerciseList, id: \.id){ exercise in
                VStack(alignment: .leading, spacing: 15){
                    
                    HStack{
                        Text(exercise.exercise)
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
                                
                                Text("\(exercise.set)")
                            }
                            
                            
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

struct CreateWorkoutSheet_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkoutSheet()
    }
}
