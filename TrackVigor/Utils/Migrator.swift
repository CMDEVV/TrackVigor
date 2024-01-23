//
//  Migrator.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 1/22/24.
//

import Foundation
import RealmSwift

class Migrator{
    init(){
        updateSchema()
    }
    func updateSchema() {
        let config = Realm.Configuration(schemaVersion: 1){ migration, oldSchemaVersion in
            
        }
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
    }
}
