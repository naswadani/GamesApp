//
//  PersistenceController.swift
//  Dicoding Games
//
//  Created by naswakhansa on 04/01/25.
//

import CoreData

public class PersistenceController {
    public static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        let bundle = Bundle(for: PersistenceController.self)

        guard let modelURL = bundle.url(forResource: "Games", withExtension: "momd") else {
            fatalError("Failed to find model file in the bundle")
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load model from file")
        }

        container = NSPersistentContainer(name: "Games", managedObjectModel: model)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent store: \(error)")
            } else {
                print("Persistent store loaded successfully.")
            }
        }
    }

    public var context: NSManagedObjectContext {
        return container.viewContext
    }
}


