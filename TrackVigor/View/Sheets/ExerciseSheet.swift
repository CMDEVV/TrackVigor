//
//  ExerciseSheet.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/10/23.
//

import SwiftUI
import MijickPopupView
import SDWebImageSwiftUI
import CoreData

struct ExerciseModelTest: Identifiable{
    var id = UUID()
    let bodyPart: String
    let name: String
}

struct ExerciseModelTestList{
    static let allExercises = [
        ExerciseModelTest(bodyPart: "chest", name: "archer push up"),
        ExerciseModelTest(bodyPart: "chest", name: "assisted wide-grip chest dip (kneeling)"),
        ExerciseModelTest(bodyPart: "chest", name: "barbell bench press"),
        ExerciseModelTest(bodyPart: "back", name: "back extension on exercise ball"),
        ExerciseModelTest(bodyPart: "back", name: "back pec stretch"),
        ExerciseModelTest(bodyPart: "cardio", name: "jack burpee"),
    ]
}


struct ExerciseSheet: View {
    
    @EnvironmentObject var dataController : DataController
    @Binding var selectedExercise: [String]
//    let fetchExercises : FetchRequest<ExerciseEntity>
    
    @FetchRequest(
        entity: ExerciseEntity.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
      ) var fetchExercises: FetchedResults<ExerciseEntity>
    
//    init(){
//        fetchExercises = FetchRequest<ExerciseEntity>(entity: ExerciseEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseEntity.name, ascending: false)])
//        selectedExercise = [""]
//    }
    
    @State var bodyPartModel = [BodyPartModel]()
    @State var exerciseBodyPart = [ExerciseBodyPart]()
    @State var exercises = ExerciseModelTestList.allExercises
    @State var selected = "All"
    @State var bodyParts = ["All","back","cardio","chest","lower arms","lower legs","neck","shoulders","upper arms","upper legs","waist"]
    @State var selectedPart = String()

    @State var goToView = false

    @State var bodyPartSelected = String()
    @State var nameSelected = String()
    @State var equipmentSelected = String()
    @State var instructionSelected = [String]()
    @State var imgSelected = String()
    
    @State private var gifImage: UIImage? = nil
    @State var selection = [String]()

    
    
    let row = [
            GridItem(.flexible())
        ]
    
    
    var body: some View {
            VStack{
                // Search Bar View
                SearchView()
                    .padding(.vertical, 30)
                
                ScrollView(.horizontal){
                    TabHeaderView()
                }
                
                ScrollView{
                    ExerciseListView()
                }
                .padding(.top, 10)
                .scrollIndicators(.hidden)
                
            }
            .padding()
            .onAppear{
//                getExercise()
            }
            .onDisappear{
                selectedExercise = selection
            }
            .implementPopupView()
        
    }
    
    func deleteExercise(at offsets: IndexSet){
        for offset in offsets{
//            let exercise = fetchExercises.wrappedValue[offset]
            let exercise = fetchExercises[offset]
            dataController.delete(exercise)
        }
        dataController.save()
    }
    
    @ViewBuilder
    func TabHeaderView() -> some View {
        HStack{
            LazyHGrid(rows: row){
                ForEach(bodyParts, id: \.self){ item in
                    VStack(spacing: 13){
                        
                        Image(item)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(selected == item ? Color.blue.opacity(0.16) : Color.gray.opacity(0.1))
                            }
                            .onTapGesture {
                                selected = item
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 69)
                            
                        
                        Text(item)
                            .frame(width: 90, height: 40)
                            .padding(.horizontal, 5)
                            .fixedSize()
                            .font(.custom("Helvetica", size: 14))
                            .background(selected == item ? Color.blue : Color.gray.opacity(0.1))
                            .foregroundColor(selected == item ? Color.white : Color.black)
                            .onTapGesture {
                                selected = item
                            }
                            .cornerRadius(10)
                    }
                }
            }
        }
        .frame(height: 135)
    }
    
    @ViewBuilder
    func ExerciseListView() -> some View {
        VStack{
            
//            if exerciseBodyPart.isEmpty{
//                ProgressView("Loading...")
//            }
            
//            ForEach(exerciseBodyPart, id: \.id){ exercise in
            ForEach(fetchExercises){ exercise in
                
                MultipleSelectionRow(name: exercise.name!, bodyPart: exercise.bodyPart!,equipment: exercise.equipment!,gifUrl: exercise.gifUrl!,instructions: exercise.instructions!, isSelected: self.selection.contains(exercise.name!)){
                    if self.selection.contains(exercise.name!){
                        self.selection.removeAll(where: {$0 == exercise.name!})
                    }else{
                        self.selection.append(exercise.name!)
                    }
                }

                
//                .padding()
            }
//            .onDelete(perform: deleteExercise)
//            .frame(maxWidth: .infinity)
//            .frame(height: 90)
//            .background(.white)
//            .cornerRadius(10)
//            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            
        }
        .padding(.vertical, 5)
        .padding(.horizontal,5)
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
            
            
            // Create New Exercise
            Button{
                CreateExercisePopup().showAndStack()
            } label: {
                Image("plus")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .frame(width: 22, height: 22)
                    .padding(15)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.gray.opacity(0.1))
                    }
            }
        }
        .frame(height: 20)
    }
    
    func getExercise(){
        let headers = [
            "X-RapidAPI-Key": Bundle.main.infoDictionary?["API_KEY"]  as? String ?? "",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        
//        print("partttt", part)
        // For any body part that have spaces and this between them %20
        // to get data
//        let urlString = part.replacingOccurrences(of: " ", with: "%20")

        guard let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises?limit=10") else {
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
                    print("ExerciseData", decodedData.count)
                    self.exerciseBodyPart = decodedData
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getBodyParts(){
        let headers = [
            "X-RapidAPI-Key": Bundle.main.infoDictionary?["API_KEY"]  as? String ?? "",
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


//struct ExerciseSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseSheet()
//            .implementPopupView()
//    }
//}
