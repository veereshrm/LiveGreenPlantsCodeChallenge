//
//  LGPNavigationControllerViewController.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 24/05/22.
//

import UIKit

protocol LGPNavigationControllerViewControllerDelegate {
    func refreshRootViewController()
}

class LGPNavigationControllerViewController: UINavigationController {
    var lgpNavigationDelegate : LGPNavigationControllerViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
