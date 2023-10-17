//
//  PopupView.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/11/23.
//

import SwiftUI
import MijickPopupView
import SDWebImageSwiftUI
import CoreData

struct CreateExercisePopup: CentrePopup{
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : CreateExercisePersistence
    
    
    @State var name: String = ""
    @State var instructions = [String]()
    @State var selection = "select"
    var bodyParts = ["select","back","cardio","chest","lower arms","lower legs","neck","shoulders","upper arms","upper legs","waist"]
    
    func createContent() -> some View {
        VStack{
            // Header View
            HStack(alignment: .center, spacing: 12){
                
                Button{
                    dismiss()
                } label: {
                    Image("close")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 12, height: 12)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.gray.opacity(0.1))
                        )
                        .padding(.top, 15)
//                        .padding(.leading, 15)
                }
                
                Spacer()
                
                Text("Create Exercise")
                    .font(.headline)
                
                Spacer()
                
                Button{
                    // Save Context
                    let newExercise = ExerciseEntity(context: dataController.container.viewContext)
                    newExercise.name = self.name
                    newExercise.bodyPart = self.selection
                    newExercise.instructions = ["Making a new exercise"] as? [String]
                    newExercise.equipment = ""
                    newExercise.gifUrl = ""
                    dataController.save()
                    
                    dismiss()
                }label: {
                    Text("Done")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
//                .padding(.trailing, 15)
                
            }
            
            // Context View
            ScrollView{
                VStack(alignment: .leading, spacing: 14){
                    TextField("Name", text: $name)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    
                    Picker("Body Part", selection: $selection){
                        ForEach(bodyParts, id: \.self){ bodyPart in
                            Text(bodyPart)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    VStack(alignment: .leading, spacing: 12){
                        Text("Instructions")
                            .font(.headline.bold())
                        
//                        TextEditor(text: $instructions)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 130)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(.gray, lineWidth: 1)
//                            )
                        
                    }
                   
                    
                }
                    
            }
            .frame(height: 300)
        }.padding(.horizontal, 15)
    }
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup
            .horizontalPadding(20)
            .cornerRadius(16)
    }
}


struct ExerciseInfoPopup: CentrePopup {
//    @Environment(\.dismiss) var dismiss
    @Binding var name: String
    @Binding var equipment: String
    @Binding var instructions: [String]
    @Binding var exerciseImg: String
    
    func createContent() -> some View {
        VStack{
            AnimatedImage(url: URL(string: exerciseImg))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top,8)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .cornerRadius(10)
                .overlay(alignment: .topTrailing){
                    Button{
                        dismiss()
                    } label: {
                        Image("close")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 12, height: 12)
                            .padding(15)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.gray.opacity(0.1))
                            )
                            .padding(.top, 15)
                            .padding(.trailing, 15)
                    }
                }
            
            VStack{
                HStack{
                    Text(name)
                        .font(.title2.bold())
                    Spacer()
                    
                    Text(equipment)
                        .lineLimit(1)
                        .frame(height: 30)
                        .padding(.horizontal, 10)
                        .font(.caption.bold())
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.red.opacity(0.1))
                        }
                        .padding(.trailing, 15)
                }
                
                VStack(alignment: .leading, spacing: 12){
                    
                    Text("Instructions")
                        .font(.headline)
                    
                    ScrollView{
                        VStack(alignment: .leading, spacing: 10){
                            ForEach(instructions, id: \.self){ item in
                                Text(item)
                                    .font(.caption)
                            }
                        }
                    }
                    .frame(height: 250)
                }
                .padding(.top, 30)
            }
            .padding(15)
            
        }
    }
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup
            .horizontalPadding(20)
            .cornerRadius(16)
    }
    
}

