//
//  LGPProductListProtocols.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation
import UIKit

/**
 - LGPProductListViewToPresenterProtocol  - protocol methods used send view events to presenter
 */
protocol LGPProductListViewToPresenterProtocol: AnyObject {
    var view: LGPProductListPresenterToViewProtocol? {get set}
    var interactor: LGPProductListPresenterToInteractorProtocol? {get set}
    var router: LGPProductListPresenterToRouterProtocol? {get set}
    
    func updateStoreInfoSection(logoImage:UIImageView, infoLabel:UILabel)
    func didUpdateSubViews()
    func numberOfSectionInTable()->Int
    func numberOfRowsInSection()->Int
    func getCell(tableView:UITableView, forRowAt indexPath:IndexPath) -> LGPProductCell
    func registerTableWithCell(tabelView:UITableView)
    func handleQuantitySelection(incrementButton:UIButton, tableView:UITableView, isIncrement:Bool)
    func navigateToOrderSummary()
    
}

/**
 - LGPProductListPresenterToViewProtocol  - protocol methods used  view updates events from presenter to view
 */
protocol LGPProductListPresenterToViewProtocol : AnyObject{
    func showFetchProductListSuccess()
    func showFetchStoreInfoSuccess()
    func showFetchProductListFailure()
    func showFetchStoreInfoFailure()
    func refresh(indexPath:IndexPath)
    func enableViewSummaryButton(isEnable:Bool)
    
}

/**
 - LGPProductListPresenterToRouterProtocol  - protocol methods used  for navigtion
 */
protocol LGPProductListPresenterToRouterProtocol : AnyObject{
    
    static func createModule()-> LGPProductListViewController
    func navigateToOrderSummary(view : LGPProductListPresenterToViewProtocol?, productList:[LGPProduct]?)
}

/**
 - LGPProductListPresenterToInteractorProtocol  - protocol methods used  for presenter to Interactor communication
 */
protocol LGPProductListPresenterToInteractorProtocol : AnyObject{
    var presenter:LGPProductListInteractorToPresenterProtocol? {get set}
    var  products : [LGPProduct]? {get set}
    var  stroreInfo : LGPStore? {get set}
    func fetchProductList()
    func fetchStoreInfo()
    func fetchSelectedProducts()
    func updateProductListForQuatitySelection(on index: Int, isIncrement:Bool)
}

/**
 - LGPProductListInteractorToPresenterProtocol  - protocol methods used  for  Interactor to presentercommunication
 */
protocol LGPProductListInteractorToPresenterProtocol : AnyObject {
    func fetchProductListSuccess(products:[LGPProduct]?)
    func fetchStoreInfoSuccess(stroreInfo:LGPStore?)
    func fetchProductListFailure()
    func fetchStoreInfoFailure()
    func fetchSelectedProductsSuccess(products:[LGPProduct]?)
    func updateProductListForQuatitySelectionSuccess(products:[LGPProduct]?)
}
