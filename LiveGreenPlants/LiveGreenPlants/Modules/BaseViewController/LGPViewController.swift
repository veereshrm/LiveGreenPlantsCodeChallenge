//
//  LGPViewController.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import UIKit

class LGPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()

        // Do any additional setup after loading the view.
    }
    
    private func setUI() {
        self.title = getNavigationTitleText()
        self.navigationItem.hidesBackButton = self.isHideBackButton()
    }
    
    func getNavigationTitleText() -> String{
        return "LiveGreenPlants"
    }
    
    func isHideBackButton() -> Bool{
        return false
    }

    

}
