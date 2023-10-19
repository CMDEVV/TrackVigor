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

enum ActiveExerciseAlert {
    case name,bodyPart,equipment
}

enum ImageType {
    case first,second
}

struct CreateExercisePopup: CentrePopup{
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    
    @State var name: String = ""
    @State var instructions = [String]()
    @State var instructionText = String()
    @State var selection = "select"
    @State var equipmentSelection = "other"
    var bodyParts = ["select","back","cardio","chest","lower arms","lower legs","neck","shoulders","upper arms","upper legs","waist"]
    var equipment = ["other","band","barbell","body weight","bosu ball","cable","dumbbell","elliptical machine","ez barbell","kettlebell","leverage machine","rope","smith machine","resistance band","sled machine"]
    

    @State var showAlert: Bool = false
    @State var activeAlert: ActiveExerciseAlert = .name
    
    @FocusState var instructionFocus: Bool

    
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
                    
                    if self.name.isEmpty{
                        self.activeAlert = .name
                        self.showAlert = true
                    } else if self.selection == "select"{
                        self.activeAlert = .bodyPart
                        self.showAlert = true
                    }else if self.equipment.isEmpty{
                        self.activeAlert = .equipment
                        self.showAlert = true
                    }else{
                        instructions = []
                        var strArray = [String]()
                        strArray.append(instructionText)
                        instructions = strArray
                        // Save Context
                        let newExercise = ExerciseEntity(context: dataController.container.viewContext)
                        newExercise.name = self.name
                        newExercise.bodyPart = self.selection
                        newExercise.instructions = instructions
                        newExercise.equipment = self.equipmentSelection
                        newExercise.gifUrl = ""
                        dataController.save()
                      
                        dismiss()
                        
                    }
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
                    
                    
                    BodyPartView()
                   
                    EquipmentView()
                    
                    VStack(alignment: .leading, spacing: 12){
                        Text("Instructions")
                            .font(.subheadline.bold())
                        
                        TextEditor(text: $instructionText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 130)
                            .focused($instructionFocus)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                            )
//                            .onChange(of: instructionText){ value in
////                                print("valuee", value)
//                                instructions.append(value)
//                                print("instructionsAppend", instructions)
//                            }
                    }
                }
            }
            .frame(height: 300)
            .padding(.bottom, 15)
        }
        .padding(.horizontal, 15)
        .toolbar{
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button("Done"){
                    instructionFocus = false
                }
                .foregroundColor(Color.blue)
            }
        }
        .alert(isPresented: $showAlert){
            switch activeAlert {
            case .name:
                return Alert(title: Text("Name is empty"), message: Text("Enter Name"), dismissButton: .default(Text("OK")))
            case .bodyPart:
                return Alert(title: Text("Body Part is empty"), message: Text("Select body part"), dismissButton: .default(Text("OK")))
            case .equipment:
                return Alert(title: Text("Equipment is empty"), message: Text("Select Equipment"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    @ViewBuilder
    func BodyPartView() -> some View {
        VStack(alignment: .leading, spacing: 13){
            Text("Body Part")
                .font(.subheadline.bold())
            Menu{
                Picker("", selection: $selection){
                    ForEach(bodyParts, id: \.self){ bodyPart in
                        Text(bodyPart)
                    }
                }
            } label: {
                HStack{
                    Text(selection)
                        .font(.subheadline)
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .imageScale(.medium)
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3),radius: 5, x: 0, y: 2)
            }
            .padding(.horizontal, 5)
        }
    }
    
    
    @ViewBuilder
    func EquipmentView() -> some View{
        VStack(alignment: .leading, spacing: 13){
            Text("Equipment")
                .font(.subheadline.bold())
            
            Menu{
                Picker("", selection: $equipmentSelection){
                    ForEach(equipment, id: \.self){ item in
                        Text(item)
                    }
                }
            } label: {
                HStack{
                    Text(equipmentSelection)
                        .font(.subheadline)
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .imageScale(.medium)
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3),radius: 5, x: 0, y: 2)
            }
            .padding(.horizontal, 5)
        }
        .padding(.vertical, 15)
    }
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup
            .horizontalPadding(20)
            .cornerRadius(16)
    }
}


struct ExerciseInfoPopup: CentrePopup {

    @Binding var name: String
    @Binding var equipment: String
    @Binding var instructions: [String]
    @Binding var exerciseImg: String
    
    @State var imageType : ImageType = .first
    
    func createContent() -> some View {
        VStack{
            
            switch imageType {
            case .first:
                NoImageFoundView()
            case .second:
                GifImageView()
            }
            
            
            VStack(alignment: .leading){
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
//                .frame(maxWidth: .infinity)
            }
            .padding(15)
            
        }
        .onAppear{
            if !exerciseImg.isEmpty{
                self.imageType = .second
            }else{
                self.imageType = .first
            }
        }
    }
    @ViewBuilder
    func NoImageFoundView() -> some View {
        Image("noImage")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
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
    }
    
    @ViewBuilder
    func GifImageView() -> some View {
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
    }
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup
            .horizontalPadding(20)
            .cornerRadius(16)
    }
    
}

