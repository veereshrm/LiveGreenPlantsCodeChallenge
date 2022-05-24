//
//  LGPOrderCompletedRouter.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//

import Foundation

class LGPOrderCompletedRouter : LGPOrderCompletedPresenterToRouterProtocol {
    
    static func createModule() -> LGPOrderCompletedViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "LGPOrderCompletedViewController") as!LGPOrderCompletedViewController
        let presenter:LGPOrderCompletedViewToPresenterProtocol = LGPOrderCompletedPresenter()
        let router:LGPOrderCompletedPresenterToRouterProtocol = LGPOrderCompletedRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        return view
        
    }
    
    func navigateToBack(view: LGPOrderCompletedPresenterToViewProtocol?) {

        if let viewController = view as? LGPOrderCompletedViewController {
            if let navController = viewController.navigationController as? LGPNavigationControllerViewController{
                navController.navigateToRootView {
                    navController.lgpNavigationDelegate?.refreshRootViewController()
                }
    
            }
            
            
        }
    }
    
    
}
