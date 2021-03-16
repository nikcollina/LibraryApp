//
//  LibraryApp.swift
//  Library
//
//  Created by Nikolas Collina on 10/19/20.
//

import SwiftUI

@main
struct LibraryApp: App {
    @StateObject var libraryModel = LibraryModel()
//    var bookManager = BookManager()
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            CollectionView().environmentObject(libraryModel)
//                .environmentObject(bookManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .inactive:
                libraryModel.saveData()
                try?
                    persistenceController.container.viewContext.save()
            default:
                break
            }
        }
    }
}

struct LibraryApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
