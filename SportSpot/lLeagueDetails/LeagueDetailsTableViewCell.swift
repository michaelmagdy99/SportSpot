//
//  LeagueDetailsTableViewCell.swift
//  SportSpot
//
//  Created by rwan elmtary on 25/04/2024.
//

import UIKit

class LeagueDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var team1: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var team2: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
