/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2017C
 Assignment: 2
 Author: Nguyen Tri Dung
 ID: s3598776
 Created date: 17/12/2017
 
 Acknowledgement:
 Resource: "Start Developing iOS App (Swift) - FoodTracker - Apple"
 Link: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/#//apple_ref/doc/uid/TP40015214-CH2-SW1
 
 */

//
//  PhotoTableViewCell.swift
//  MyPhoto
//
//  Created by Dung Nguyen on 12/17/17.
//  Copyright © 2017 Dung Nguyen - s3598776. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    //MARK: Propersties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
