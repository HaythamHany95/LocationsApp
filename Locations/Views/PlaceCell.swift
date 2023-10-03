//
//  PlaceCell.swift
//  Locations
//
//  Created by Haytham on 02/10/2023.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
