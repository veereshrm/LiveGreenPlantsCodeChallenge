//
//  LGPOrderCompletedProtocol.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//

import Foundation
import UIKit

protocol LGPOrderCompletedViewToPresenterProtocol: AnyObject {
    var view: LGPOrderCompletedPresenterToViewProtocol? {get set}
    var router: LGPOrderCompletedPresenterToRouterProtocol? {get set}
    
    func closePresentScreen()
}

protocol LGPOrderCompletedPresenterToViewProtocol : AnyObject {
    
}

protocol LGPOrderCompletedPresenterToRouterProtocol : AnyObject{
    
    static func createModule()-> LGPOrderCompletedViewController
    func navigateToBack(view : LGPOrderCompletedPresenterToViewProtocol?)
}



