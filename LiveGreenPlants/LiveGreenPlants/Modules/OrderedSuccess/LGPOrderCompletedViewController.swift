//
//  LGPOrderCompletedViewController.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//

import UIKit

class LGPOrderCompletedViewController: LGPViewController {

    var presenter:LGPOrderCompletedViewToPresenterProtocol?
    @IBOutlet weak var successLabel : UILabel!
    @IBOutlet weak var closeButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successLabel.font = lgpHeaderFont
        successLabel.textColor = lgpTextColour
        closeButton.titleLabel?.font = lgpHeaderFont
        successLabel.text = "Odered Successful"
        closeButton.setTitleColor(lgpButtonTextColour, for: .normal)
        closeButton.setTitle("Close", for: .normal)
        closeButton.backgroundColor = lgpButtonColour

        // Do any additional setup after loading the view.
    }
    
    override func getNavigationTitleText() -> String{
        return "Order Completed"
    }
    
    override func isHideBackButton() -> Bool{
        return true
    }
    
    @IBAction func closeButtonClicked(_ sender : Any) {
        presenter?.closePresentScreen()
    }
    

}

extension LGPOrderCompletedViewController : LGPOrderCompletedPresenterToViewProtocol {
    
}
