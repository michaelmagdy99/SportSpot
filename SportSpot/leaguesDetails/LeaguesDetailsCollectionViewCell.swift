//
//  LeaguesDetailsCollectionViewCell.swift
//  SportSpot
//
//  Created by rwan elmtary on 25/04/2024.
//

import UIKit

class LeaguesDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var team2: UIImageView!
    @IBOutlet weak var team1: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var imgtitle: UILabel!
    @IBOutlet weak var header: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
             
       // team1.frame = contentView.bounds
        team1.contentMode = .scaleAspectFit
        
       // team2.frame = contentView.bounds
        team2.contentMode = .scaleAspectFit
    }
    

}
