//
//  CreateExercisePersistence.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/14/23.
//

import Foundation
import CoreData


class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Workout")
    
    init() {
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
            
        }
    }
    
//    func save(context: NSManagedObjectContext) {
//        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
//        do {
//            try context.save()
//            print("Saved Data")
//        } catch{
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
    
    func save() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            }
            catch {
                fatalError("Unable to save data: \(error.localizedDescription)")
            }
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func sampleData() {
        let date = Date()
        let formatDate = date.getFormattedDate(format: "MM-dd-yyyy")
        let viewContext = container.viewContext

     
        
        let addSet1 = AddSet(context: viewContext)
        addSet1.id = UUID()
        addSet1.set = "1"
        addSet1.lbs = "40"
        addSet1.reps = ""
        
        let addSet2 = AddSet(context: viewContext)
        addSet2.id = UUID()
        addSet2.lbs = "50"
        addSet2.reps = "10"
        addSet2.set = "2"
        
        let addSet3 = AddSet(context: viewContext)
        addSet3.id = UUID()
        addSet3.lbs = "60"
        addSet3.reps = "8"
        addSet3.set = "3"
        
        
        let exercise1 = Exercise(context: viewContext)
        exercise1.id = UUID()
        exercise1.name = "Bench Press (New)"
        exercise1.addSet = [addSet1, addSet2]
        
       
        let exercise2 = Exercise(context: viewContext)
        exercise2.id = UUID()
        exercise2.name = "Leg Press (New)"
        exercise2.addSet = [addSet1]
        
        let exercise3 = Exercise(context: viewContext)
        exercise3.id = UUID()
        exercise3.name = "shoulder Press (New)"
        
        let workout = Workout(context: viewContext)
        workout.id = UUID()
        workout.name = "Testing New Workout"
        workout.creationDate = formatDate
        workout.exercise = [exercise1,exercise2]
       
        
        do {
            try viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
        
    }
    
//    func deleteAll() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = School.fetchRequest()
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        _ = try? container.viewContext.execute(batchDeleteRequest)
//    }
    
//    func addExercise(name: String, bodyPart: String, instructions: String, context: NSManagedObjectContext){
//        let exercise = ExerciseEntity(context: context)
//        exercise.name = name
//        exercise.bodyPart = bodyPart
//        exercise.instructions = instructions
//
//        save(context: context)
//    }
    
//    func getAllExercises() -> [ExerciseEntity]{
//        let fetchRequest: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()
//
//        do{
//            return try container.viewContext.fetch(fetchRequest)
//        } catch {
//            return []
//        }
//    }
    
}


