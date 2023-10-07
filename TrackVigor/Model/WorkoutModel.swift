//
//  WorkoutModel.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import Foundation


struct WorkoutModel: Identifiable{
    var id = UUID()
    let name: String
    let timer: Int
    let date: String
}


struct WorkoutModelList {
    static let allWorkouts = [
        WorkoutModel(name: "Morning Workout", timer: 45, date: "10/04/23"),
        WorkoutModel(name: "Morning Workout", timer: 45, date: "10/05/23"),
        WorkoutModel(name: "Morning Workout", timer: 45, date: "10/06/23"),
        WorkoutModel(name: "Morning Workout", timer: 30, date: "10/10/23"),
    ]
}
