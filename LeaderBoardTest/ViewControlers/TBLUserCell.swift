//
//  TBLUserCell.swift
//  LeaderBoardTest
//
//  Created by Bhavesh Kumbhani on 04/12/18.
//  Copyright © 2018 Bhavesh Kumbhani. All rights reserved.
//

import UIKit

class TBLUserCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = 30.0
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
