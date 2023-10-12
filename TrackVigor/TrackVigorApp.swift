//
//  TrackVigorApp.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/7/23.
//

import SwiftUI

@main
struct TrackVigorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Tabbar()
                .implementPopupView()
               // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
