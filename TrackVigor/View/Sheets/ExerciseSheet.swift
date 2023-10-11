//
//  ExerciseSheet.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/10/23.
//

import SwiftUI
// Get BodyParts
// Select body part (back) -> List all back workouts(limit to 10-20)
// Have info icon beside exercise open a and show (gif,instructions and equipment)


struct ExerciseSheet: View {
    @State var bodyPartModel = [BodyPartModel]()
    @State var bodyParts = [String]()
    @State var selectedPart = String()
    
    @State var goToView = false
    var body: some View {
        NavigationStack{
            VStack{
                // Search Bar View
                SearchView()
                    .padding(.top, 30)
                ScrollView{
                    // BodyParts View
                    BodyPartsView()
                }
                .padding(.top, 40)
            }
            .padding()
            .onAppear{
                getBodyParts()
            }
        }
    }
    
    @ViewBuilder
    func BodyPartsView() -> some View {
        VStack{
            ForEach(bodyParts, id: \.self){ bodyPart in
                    Text(bodyPart)
                    .onTapGesture {
                        goToView = true
                        selectedPart = bodyPart
                    }
                    .background(
                        NavigationLink(destination: ExerciseBodyPartView(bodyPart: $selectedPart), isActive: $goToView){}
                    )
               
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    func SearchView() -> some View{
        HStack(spacing: 15){
            HStack(spacing: 15){
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                
                Divider()
                TextField("Search", text: .constant(""))
                
                
            }
            .padding(15)
            .background{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            }
        }
        .frame(height: 20)
    }
    
    func getBodyParts(){
        let headers = [
            "X-RapidAPI-Key": "28e61f3803msh08bff9f89b62fd1p1c449fjsnfee6846f1119",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        
        guard let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises/bodyPartList") else {
            print("Error: cannot create URL")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
//            guard let data = data else {
//                print("Error: Did not receive data")
//                return
//            }
          
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let data = data {
                do {
                    if let responseArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                        // Store the array into bodyPartModel
                        bodyParts = responseArray
                    }
                } catch {
                    print("Error parsing JSON:", error)
                }
            }
  
        }.resume()
    }
    
}

struct GIFImageView: UIViewRepresentable {
    let imageName: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        if let gifImage = UIImage(named: imageName) {
            uiView.image = gifImage
        }
    }
}

struct ExerciseSheet_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSheet()
    }
}
