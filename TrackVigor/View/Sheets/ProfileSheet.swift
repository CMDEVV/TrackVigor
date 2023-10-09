//
//  ProfileSheet.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import SwiftUI
import InitialsUI


struct AppInformation: Identifiable{
    var id = UUID()
    let title: String
    let image: Image
}

struct AppInformationList{
    static let allAppInformation = [
        AppInformation(title: "Feedback", image: Image(systemName: "info.circle")),
        AppInformation(title: "Rate App", image: Image(systemName: "info.circle")),
        AppInformation(title: "Version", image: Image(systemName: "info.circle")),
    ]
}

struct ProfileSheet: View {
    @State var appInformation = AppInformationList.allAppInformation
    
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment: .leading){
                    // Header View
                    HeaderView()
                   // Information View
                    InformationView()
                    
                    Spacer()
                }
                
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack(alignment: .center, spacing: 20){
            InitialsUI(initials: "CM", useDefaultForegroundColor: true, fontWeight: nil, randomBackground: true)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            Text("testemail@test.com")
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0,y: 2)
        .padding(15)
        .padding(.top, 20)
    }
    
    @ViewBuilder
    func InformationView() -> some View{
        VStack(alignment: .leading, spacing: 20){
            Text("Information")
                .font(.title3.bold())
            
            ForEach(appInformation, id: \.id){ item in
                HStack(alignment: .center, spacing: 13){
                    item.image
                        .imageScale(.medium)
                    
                    Text(item.title)
                        .font(.subheadline)
                    Spacer()
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            
            SignoutButton()
        }
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func SignoutButton() -> some View {
        Button{
            
        } label: {
            HStack(alignment: .center, spacing: 13){
                Image(systemName: "rectangle.portrait.and.arrow.right")
                
                Text("Sign out")
                    .font(.subheadline)
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct ProfileSheet_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSheet()
    }
}
