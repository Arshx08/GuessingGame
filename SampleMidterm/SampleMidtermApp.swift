//
//  SampleMidtermApp.swift
//  SampleMidterm
//
//  Created by Arshdeep Singh on 2023-10-17.
//

import SwiftUI

@main
struct SampleMidtermApp: App {
    let persistenceController = PersistenceController.shared
    let dbHelper = DBHelper.getInstance()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            Mainview().environmentObject(self.dbHelper)
        }
    }
}
