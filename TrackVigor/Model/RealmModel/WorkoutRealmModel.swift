//
//  WorkoutRealmModel.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 1/22/24.
//

import Foundation
import RealmSwift

class WorkoutRealmModel: Object, Identifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var date: String
    @Persisted var name: String
    @Persisted var exercises = List<ExerciseRealmModel>()
}

class ExerciseRealmModel: Object{
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name: String
    @Persisted var addSet = List<AddSetRealmModel>()
}

class AddSetRealmModel: Object{
    @Persisted(primaryKey: true) var id = 0
    @Persisted var lbs: String
    @Persisted var rep: String
    @Persisted var set: String
}


class CreateExerciseRealmModel: Object{
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name: String
    @Persisted var bodyPart: String
    @Persisted var equipment: String
    @Persisted var gifUrl: String
    @Persisted var instructions = List<String>()
    
}
