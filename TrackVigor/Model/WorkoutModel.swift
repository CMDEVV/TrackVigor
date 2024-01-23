//
//  WorkoutModel.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import Foundation


struct WorkoutModel: Identifiable{
    var id = UUID()
    var name: String
    var creationDate: String
    var exercises: [ExericiseModel]
}

struct ExericiseModel: Identifiable{
    var id = UUID()
    var name: String
    var addSet: [AddSetModel]
}

struct AddSetModel: Identifiable{
    var id = UUID()
    var lbs: String
    var reps: String
    var set: String
}


struct WorkoutModelList{
    static var allWorkouts = [
        WorkoutModel(name: "Noon Exercise", creationDate: "01/21/22", exercises: []),
        WorkoutModel(name: "Morning Exercise", creationDate: "01/21/22", exercises: []),
        WorkoutModel(name: "Night Exercise", creationDate: "01/21/22", exercises: []),
    ]
}

