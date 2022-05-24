//
//  LGPNavigationControllerAddition.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 24/05/22.
//

import UIKit

extension UINavigationController {
    
    func navigateToRootView(completion: @escaping ()->Void) {
        self.popToRootViewController(animated: true)
        completion()
    }
}

