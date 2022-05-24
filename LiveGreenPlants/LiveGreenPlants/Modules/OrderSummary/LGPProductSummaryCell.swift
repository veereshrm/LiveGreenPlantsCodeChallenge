//
//  LGPProductSummaryCell.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//

import UIKit

class LGPProductSummaryCell: UITableViewCell {

    @IBOutlet weak var productImageView : UIImageView!
    @IBOutlet weak var productSummaryLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
