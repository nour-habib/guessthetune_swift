//
//  TrackItem+CoreDataProperties.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-11.
//
//

import Foundation
import CoreData


extension TrackItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackItem> {
        return NSFetchRequest<TrackItem>(entityName: "TrackItem")
    }

    @NSManaged public var album: String?
    @NSManaged public var artists: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

//extension TrackItem : Identifiable {
//
//}
