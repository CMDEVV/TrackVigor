//
//  TrackVigorApp.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import SwiftUI

@main
struct TrackVigorApp: App {
    
//    let persistenceController = PersistenceController.shared
    @StateObject var createExercisePersistence: CreateExercisePersistence
    
    init() {
        let createExercisePersistence = CreateExercisePersistence()
        _createExercisePersistence = StateObject(wrappedValue: createExercisePersistence)
    }
    
  

    var body: some Scene {
        WindowGroup {
            Tabbar()
                .implementPopupView()
                .environment(\.managedObjectContext, createExercisePersistence.container.viewContext)
                .environmentObject(createExercisePersistence)
        }
    }
}
