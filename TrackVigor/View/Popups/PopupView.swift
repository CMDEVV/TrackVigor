//
//  PopupView.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/11/23.
//

import SwiftUI
import MijickPopupView
import SDWebImageSwiftUI


struct ExerciseInfoPopup: CentrePopup {
//    @Environment(\.dismiss) var dismiss
    @Binding var name: String
    @Binding var equipment: String
    @Binding var instructions: [String]
    @Binding var exerciseImg: String
    
    func createContent() -> some View {
        VStack{
//            Image(exerciseImg)
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
                    }label: {
                        Image(systemName: "x.circle")
                            .imageScale(.large)
                    }
                    .frame(width: 22, height: 22)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.gray.opacity(0.2))
                    }
                    .padding(.trailing, 15)
                    .padding(.top, 15)
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
//struct PopupView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopupView()
//    }
//}
