//
//  LGPAddressCell.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//

import UIKit

class LGPAddressCell: UITableViewCell {

    @IBOutlet weak var addressTitleLabel : UILabel!
    @IBOutlet weak var addressTextView : UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addressTextView.addKeyboardToolBar()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
