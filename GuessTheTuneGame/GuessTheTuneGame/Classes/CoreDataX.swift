//
//  CoreDataX.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation
import CoreData

enum CoreDataError: Error
{
    case saveError
    case deleteError
    case searchError
}

class CoreDataX
{
    static let shared = CoreDataX()
    
    init(){}
    
    //Create and save TrackItem
    func saveItem(track: Track)
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
            print("save error")
        }
    }

    func deleteItem(track: TrackItem)
    {
        context.delete(track)
        do
        {
            try context.save()
        }
        catch
        {
            print("delete error")
        }
    }
}
