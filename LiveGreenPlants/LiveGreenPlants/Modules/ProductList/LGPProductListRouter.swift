//
//  LGPProductListRouter.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation
import UIKit

class LGPProductListRouter : LGPProductListPresenterToRouterProtocol {
    
    static func createModule() -> LGPProductListViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "LGPProductListViewController") as! LGPProductListViewController
        let presenter: LGPProductListViewToPresenterProtocol & LGPProductListInteractorToPresenterProtocol = LGPProductListPresenter()
        let interactor: LGPProductListPresenterToInteractorProtocol = LGPProductListInteractor()
        let router:LGPProductListPresenterToRouterProtocol = LGPProductListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
    
    func navigateToOrderSummary(view : LGPProductListPresenterToViewProtocol?, productList:[LGPProduct]?){
        if let viewController = view as? LGPProductListViewController {
             let orderSummaryView = LGPOrderSummaryRouter.createModule(selectedProducts: productList)
            viewController.navigationController?.pushViewController(orderSummaryView, animated: true)
        }
    }
    
    
}

