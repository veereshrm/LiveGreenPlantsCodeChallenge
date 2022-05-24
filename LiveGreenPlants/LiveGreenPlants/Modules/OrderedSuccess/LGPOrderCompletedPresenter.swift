//
//  LGPOrderCompletedPresenter.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//

import Foundation

class LGPOrderCompletedPresenter : LGPOrderCompletedViewToPresenterProtocol {
    weak var view: LGPOrderCompletedPresenterToViewProtocol?
    var router: LGPOrderCompletedPresenterToRouterProtocol?
    
    func closePresentScreen() {
        router?.navigateToBack(view: view)
    }
    
}
