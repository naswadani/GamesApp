//
//  EntityGames+CoreDataProperties.swift
//
//
//  Created by naswakhansa on 27/01/25.
//
//

import Foundation
import CoreData


extension EntityGames {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityGames> {
        return NSFetchRequest<EntityGames>(entityName: "EntityGames")
    }
    
    @NSManaged public var backgroundImage: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var rating: String?
    @NSManaged public var released: String?
    
    public var toGame: Game {
        return Game(
            id: Int(self.id),
            name: self.name ?? "",
            released: self.released ?? "",
            backgroundImage: self.backgroundImage ?? "",
            rating: Double(self.rating ?? "") ?? 0.0,
            isFavorite: true
        )
    }
    
    
}
