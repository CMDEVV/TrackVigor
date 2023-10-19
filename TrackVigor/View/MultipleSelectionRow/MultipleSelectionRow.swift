//
//  MultipleSelectionRow.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/18/23.
//

import SwiftUI
import MijickPopupView

//struct MultipleSelectionRow: View {
//    var title : String
//    var isSelected: Bool
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: self.action){
//            HStack{
//                Text(self.title)
//                    .font(.subheadline)
//                    .foregroundColor(.black)
//            }
//            .frame(maxWidth: .infinity)
//            .frame(height: 44)
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(self.isSelected ? Color.blue : .clear, lineWidth: 1)
//            )
//        }
//    }
//}

struct MultipleSelectionRow: View {
    var name : String
    var bodyPart: String
    var equipment: String
    var gifUrl: String
    var instructions: [String]
    var isSelected: Bool
    var action: () -> Void
    
    
    @State var bodyPartSelected = String()
    @State var nameSelected = String()
    @State var equipmentSelected = String()
    @State var instructionSelected = [String]()
    @State var imgSelected = String()
    
    var body: some View {
        Button(action: self.action){
            VStack(alignment: .leading,spacing: 13){
             HStack{
                Text(bodyPart)
                    .frame(width: 60, height: 30)
                    .font(.subheadline)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.gray.opacity(0.1))
                    }
                
                Spacer()
                
                Button{
                    // Show How do exercise
                    nameSelected = name
                    equipmentSelected = equipment
                    instructionSelected = instructions
                    imgSelected = gifUrl
                    ExerciseInfoPopup(name: $nameSelected, equipment: $equipmentSelected, instructions: $instructionSelected, exerciseImg: $imgSelected).showAndStack()
                } label: {
                    Image(systemName: "info.circle")
                        .imageScale(.medium)
                        
                }
                .frame(width: 24, height: 24)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.gray.opacity(0.1))
                }
                
            }
                
                Text(name)
                    .font(.subheadline)
                    .lineLimit(1)
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(self.isSelected ? Color.blue : .clear, lineWidth: 1)
            )
        }
    }
}



//VStack(alignment: .leading,spacing: 13){
// HStack{
//    Text(exercise.bodyPart ?? "")
//        .frame(width: 60, height: 30)
//        .font(.subheadline)
//        .background{
//            RoundedRectangle(cornerRadius: 10, style: .continuous)
//                .fill(Color.gray.opacity(0.1))
//        }
//
//    Spacer()
//
//    Button{
//        // Show How do exercise
//        nameSelected = exercise.name ?? ""
//        equipmentSelected = exercise.equipment ?? ""
//        instructionSelected = exercise.instructions!
//        imgSelected = exercise.gifUrl ?? ""
//        ExerciseInfoPopup(name: $nameSelected, equipment: $equipmentSelected, instructions: $instructionSelected, exerciseImg: $imgSelected).showAndStack()
//    } label: {
//        Image(systemName: "info.circle")
//            .imageScale(.medium)
//
//    }
//    .frame(width: 24, height: 24)
//    .background{
//        RoundedRectangle(cornerRadius: 10, style: .continuous)
//            .fill(Color.gray.opacity(0.1))
//    }
//
//}
//
//    Text(exercise.name ?? "")
//        .font(.subheadline)
//        .lineLimit(1)
//
////                    Button{
////                        // Delete Item
////                        dataController.delete(exercise)
////                        dataController.save()
////                    }label: {
////                        Text("Delete")
////                            .frame(width: 140, height: 50)
////                            .background(Color.blue)
////                            .foregroundColor(Color.white)
////                            .cornerRadius(10)
////                    }
//}
