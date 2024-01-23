//
//  TrackVigorApp.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import SwiftUI

@main
struct TrackVigorApp: App {
    let migrator = Migrator()
//    let persistenceController = PersistenceController.shared
//    @StateObject var dataController: DataController
//    
//    init() {
//        let dataController = DataController()
//        _dataController = StateObject(wrappedValue: dataController)
//    }
    
  
    var body: some Scene {
        WindowGroup {
            Tabbar()
                .implementPopupView()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
//                .environmentObject(dataController)
        }
    }
}
