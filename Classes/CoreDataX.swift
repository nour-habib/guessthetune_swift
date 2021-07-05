//
//  CoreDataX.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-07-05.
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
    func createItem(track: Track)
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
    
    
    //search for duplicates
    func search(track: Track)
    {
//        let id = track.id
//        let request: NSFetchRequest<TrackItem> = TrackItem.fetchRequest()
//        request.predicate = NSPredicate(format: "id CONTAINS %@",id)
//
//        do
//        {
//            if (try context.execute(request)) != nil
//            {
//
//            }
            
//        }
//        catch let error
//        {
//            print(error)
//        }
//
    }
    
//    func saveError() throws
//    {
//        throw CoreDataError.saveError
//    }
//





}

