//
//  TableCellTableViewCell.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/3/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit

class TableCellTableViewCell: UITableViewCell {

    
    func configureUI(firstName:String, lastName:String, mediaURL:String, image:UIImage? = UIImage(systemName: "mappin.and.ellipse")) {
        self.imageView?.image = image
        self.textLabel?.text = firstName + " " + lastName
        self.detailTextLabel?.text = mediaURL
    }

}
