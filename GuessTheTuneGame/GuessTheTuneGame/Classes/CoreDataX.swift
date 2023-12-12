//
//  CoreDataX.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import CoreData

class CoreDataX
{
    init(){}
    
    var managedObjectContext: NSManagedObjectContext?
    
    func saveItem(track: Track) throws
    {
        guard let managedObjectContext = managedObjectContext else {return}

        let newTrackItem = TrackItem(context: managedObjectContext)
        newTrackItem.album = track.album?.name
        newTrackItem.artists = track.artists[0].name
        newTrackItem.id = track.id
        newTrackItem.name = track.name

        do
        {
            try managedObjectContext.save()
        }
        catch
        {
            throw CoreDataError.saveError
        }
    }

    func deleteItem(track: TrackItem) throws
    {
        guard let managedObjectContext = managedObjectContext else {return}
        
        managedObjectContext.delete(track)
        
        do
        {
            try managedObjectContext.save()
        }
        catch
        {
            throw CoreDataError.deleteError
        }
    }
}

enum CoreDataError: Error
{
    case saveError
    case deleteError
    case searchError
}
