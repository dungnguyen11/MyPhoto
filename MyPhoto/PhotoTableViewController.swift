//
//  PhotoTableViewController.swift
//  MyPhoto
//
//  Created by Dung Nguyen on 12/17/17.
//  Copyright © 2017 Dung Nguyen - s3598776. All rights reserved.
//

import UIKit
import os.log

class PhotoTableViewController: UITableViewController {
    //MARK: Properties
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provied by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load some sample images
        loadSamplePhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Initialize the cell as PhotoTableViewCell instance
        let cellIdentifier = "PhotoCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhotoTableViewCell else {
            fatalError("The dequeued cell is not an instance of PhotoTableViewCell")
        }
        // Get photo from photos array based on row
        let photo = photos[indexPath.row]
        
        // Set properties for the cell
        cell.photoImageView.image = photo.image
        cell.descriptionLabel.text = photo.description
    
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            photos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Check which segue is sending
        switch (segue.identifier ?? "") {
        // User add a new photo
        case "AddPhoto":
            os_log("Adding a new photo", log: OSLog.default, type: .debug)
            
        // User want to see the detail of selected photo
        case "ShowDetail":
            guard let photoDetailViewController = segue.destination as? PhotoViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedPhotoCell = sender as? PhotoTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedPhotoCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPhoto = photos[indexPath.row]
            photoDetailViewController.photo = selectedPhoto
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }
 
    
    //MARK: Actions
    @IBAction func unwindToPhotoList(sender: UIStoryboardSegue) {
       
        if let sourceViewController = sender.source as? PhotoViewController, let photo = sourceViewController.photo {
            
            if let seletedIndexPath = tableView.indexPathForSelectedRow { // User edit existing photo
                // Update an existing meal
                photos[seletedIndexPath.row] = photo
                tableView.reloadRows(at: [seletedIndexPath], with: .none)
            } else {                                                      // User create new photo
                // Add a new meal to the list of photo
                let newIndexPath = IndexPath(row: photos.count, section: 0)
                photos.append(photo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    //MARK: Private methods
    private func loadSamplePhotos() {
        // Get 3 images from Assets
        let image1 = UIImage(named: "dog1")!
        let image2 = UIImage(named: "dog2")!
        let image3 = UIImage(named: "dog3")!
        
        let photo1 = Photo(image: image1, description: "Baby Corgi")
        let photo2 = Photo(image: image2, description: "Looking Corgi")
        let photo3 = Photo(image: image3, description: "Playing Corgi")
        
        photos += [photo1, photo2, photo3]
    }
    

}
