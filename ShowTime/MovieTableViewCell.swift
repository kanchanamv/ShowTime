//
//  MovieTableViewCell.swift
//  ShowTime
//
//  Created by Kanch on 2/4/16.
//  Copyright © 2016 Kanch. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var moviesImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.darkGrayColor()
        UITableViewCell.appearance().selectedBackgroundView = selectionView

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
