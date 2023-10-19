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


