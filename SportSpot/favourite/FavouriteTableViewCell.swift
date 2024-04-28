//
//  FavouriteTableViewCell.swift
//  SportSpot
//
//  Created by rwan elmtary on 27/04/2024.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var favLeague: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
