//
//  LGPOrderSummaryRouter.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation
import UIKit

class LGPOrderSummaryRouter : LGPOrderSummaryPresenterToRouterProtocol {
    
    static func createModule(selectedProducts:[LGPProduct]?) -> LGPOrderSummaryViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "LGPOrderSummaryViewController") as! LGPOrderSummaryViewController
        let presenter: LGPOrderSummaryViewToPresenterProtocol & LGPOrderSummaryInteractorToPresenterProtocol = LGPOrderSummaryPresenter()
        let interactor: LGPOrderSummaryPresenterToInteractorProtocol = LGPOrderSummaryInteractor()
        
        let router:LGPOrderSummaryPresenterToRouterProtocol = LGPOrderSummaryRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.interactor?.selectedProducts = selectedProducts
        interactor.presenter = presenter
        return view
    }
    
    func navigateToOrderSuccess(view : LGPOrderSummaryPresenterToViewProtocol?) {
        if let viewController = view as? LGPOrderSummaryViewController {
             let orderSummaryView = LGPOrderCompletedRouter.createModule()
            viewController.navigationController?.pushViewController(orderSummaryView, animated: true)
        }
    }
    
    
}
