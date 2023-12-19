//
//  CoreDataX.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import CoreData

class CoreDataX
{
    func saveItem(track: Track) throws
    {
        let newTrackItem = TrackItem(context: context)
        newTrackItem.album = track.album?.name
        newTrackItem.artists = track.artists[0].name
        newTrackItem.id = track.id
        newTrackItem.name = track.name

        do
        {
            try context.save()
        }
        catch
        {
            throw CoreDataError.saveError
        }
    }

    func deleteItem(track: TrackItem) throws
    {
        context.delete(track)
        
        do
        {
            try context.save()
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
