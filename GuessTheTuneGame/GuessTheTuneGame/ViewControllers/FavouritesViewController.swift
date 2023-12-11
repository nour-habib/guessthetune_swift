//
//  Favourites.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-28.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let tableView: UITableView =
        {
            let table = UITableView()
            table.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
            
            return table
        }()
    
   private var favTracks = [TrackItem]()
    
    override func loadView()
    {
        super.loadView()
        self.view.tintColor = CustomColor.customGreen
        self.title = "Favourite Tracks"
        
        getAllItems()
        configureTableView()
    }
    
    init()
    {
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == .delete)
        {
            CoreData_.deleteItem(track: favTracks[indexPath.row])
            getAllItems()
            tableView.reloadData()
        }
    }
    
    func configureTableView()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = CustomColor.offWhite
        view.addSubview(tableView)
             
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return favTracks.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let tracks = favTracks[indexPath.row]
        cell.textLabel?.text = tracks.name
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size:18)
        cell.textLabel?.textColor = CustomColor.customGreen
        cell.backgroundColor = CustomColor.offWhite
        return cell
    }
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.backgroundColor = CustomColor.offWhite
    }
    
    //MARK: Get favourite tracks
    
    func getAllItems() -> Void
    {
        do
        {
            favTracks = try context.fetch(TrackItem.fetchRequest())
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        catch
        {
            //throw exception
            print("getAllItems: Error")
        }
        
    }
    

}
