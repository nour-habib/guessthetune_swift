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
    private var tableView: UITableView?
    private var favTracks: [TrackItem]?
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)
        view.tintColor = CustomColor.customGreen
        title = "Favourite Tracks"
        
        getAllItems()
        configureTableView()
        print("favTracks size: ", favTracks?.count)
    }
    
    init()
    {
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView()
    {
        print("configureTableView()")
        guard let tableView = tableView else {return}

        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = CustomColor.offWhite
        view.addSubview(tableView)
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
            if let favTracks = favTracks
            {
                do
                {
                    try CoreData_.deleteItem(track: favTracks[indexPath.row])
                }
                catch
                {
                    print("tableView edit error")
                }
            }
            getAllItems()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let favTracks = favTracks else {return 0}
        return favTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let favTracks = favTracks else {return UITableViewCell()}

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
    
    private func getAllItems()
    {
        do
        {
            self.favTracks = try managedObjectContext?.fetch(TrackItem.fetchRequest())
            guard let tableView = tableView else {return}

            DispatchQueue.main.async{
                tableView.reloadData()
            }
        }
        catch
        {
            print("getAllItems: Error")
        }
    }
}
