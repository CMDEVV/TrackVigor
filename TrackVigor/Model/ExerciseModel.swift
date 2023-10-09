//
//  ExerciseModel.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/8/23.
//

import Foundation

// Set (reps,lbs,set) to array later on
struct ExerciseModel: Identifiable{
    var id = UUID()
    let exercise: String
    let set: Int
    let lbs: Int
    let rep: Int
}

struct ExerciseModelList{
    static let allExercise = [
        ExerciseModel(exercise: "Squads", set: 2, lbs: 32, rep: 12),
        ExerciseModel(exercise: "Bench Press", set: 3, lbs: 155, rep: 12),
        ExerciseModel(exercise: "Leg Press", set: 2, lbs: 230, rep: 15),
    ]
}
