//
//  BodyPartView.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/10/23.
//

import SwiftUI

struct ExerciseBodyPartView: View {
    @State var exerciseBodyPart = [ExerciseBodyPart]()
   @Binding var bodyPart: String
    
    var body: some View {
        VStack{
            ScrollView{
                // Exercise List View
                ExerciseListView()
                
            }
        }
        .navigationTitle(bodyPart)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            print("bodyPartSel", bodyPart)
            getExercise(part: bodyPart)
        }
    }
    @ViewBuilder
    func ExerciseListView() -> some View {
        VStack{
            ForEach(exerciseBodyPart, id: \.id){ exercise in
            
                 
                    VStack(spacing: 13){
                        HStack{
                            Text(exercise.name)
                                .font(.subheadline)
                            Spacer()
                            
                            Button{
                                // Show How do exercise
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
                            
                    }
                    .padding()
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
        }
        .padding(15)
    }
    
    func getExercise(part: String){
        let headers = [
            "X-RapidAPI-Key": Bundle.main.infoDictionary?["API_KEY"]  as? String ?? "",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        
//        print("partttt", part)
        // For any body part that have spaces and this between them %20
        // to get data
        let urlString = part.replacingOccurrences(of: " ", with: "%20")

        guard let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises/bodyPart/\(urlString)?limit=10") else {
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
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            DispatchQueue.main.async {
                do {
                    let decodedData = try JSONDecoder().decode([ExerciseBodyPart].self, from: data)
                    // print("Data", decodedData)
                    self.exerciseBodyPart = decodedData
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

}

//struct BodyPartView_Previews: PreviewProvider {
//    static var previews: some View {
//        BodyPartView(bodyPart: "")
//    }
//}
