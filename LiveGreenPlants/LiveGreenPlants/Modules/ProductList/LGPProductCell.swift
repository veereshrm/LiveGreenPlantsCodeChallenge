//
//  LGPProductCell.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import UIKit

class LGPProductCell: UITableViewCell {
    
    @IBOutlet weak var productImageView : UIImageView!
    @IBOutlet weak var productTitleLabel : UILabel!
    @IBOutlet weak var productPriceLabel : UILabel!
    @IBOutlet weak var productQuantityLabel : UILabel!
    @IBOutlet weak var quantityIncrementButton : UIButton!
    @IBOutlet weak var quantityDecrementButton : UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        productTitleLabel.font = lgpTitleFont
        productPriceLabel.font = lgpSubTitleFont
        productQuantityLabel.font = lgpSubTitleFont
        quantityIncrementButton.tintColor = lgpButtonColour
        quantityDecrementButton.tintColor = lgpButtonColour
        productTitleLabel.textColor = lgpTextColour
        productPriceLabel.textColor = lgpTextColour
        productQuantityLabel.textColor = lgpTextColour
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
