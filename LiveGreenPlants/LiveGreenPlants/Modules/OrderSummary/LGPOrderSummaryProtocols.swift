//
//  LGPOrderSummaryProtocols.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation
import UIKit

/**
 - LGPOrderSummaryViewToPresenterProtocol  - protocol methods used send view events to presenter
 */
protocol LGPOrderSummaryViewToPresenterProtocol: AnyObject {
    var view: LGPOrderSummaryPresenterToViewProtocol? {get set}
    var interactor: LGPOrderSummaryPresenterToInteractorProtocol? {get set}
    var router: LGPOrderSummaryPresenterToRouterProtocol? {get set}
    
    func didUpdateSubViews()
    func numberOfRowsInSection()->Int
    func getCell(tableView:UITableView, forRowAt indexPath:IndexPath) -> UITableViewCell
    func registerTableWithCell(tabelView:UITableView)
    func handleTextViewEndEditing(textView:UITextView, tableView:UITableView)
    func placeAnOrder()
        
}

/**
 - LGPOrderSummaryPresenterToViewProtocol  - protocol methods used  view updates events from presenter to view
 */
protocol LGPOrderSummaryPresenterToViewProtocol : AnyObject{
    func reloadSubviews()
    func enablePlaceOrderButton(isEnable:Bool)

}

/**
 - LGPOrderSummaryPresenterToRouterProtocol  - protocol methods used  for navigtion
 */
protocol LGPOrderSummaryPresenterToRouterProtocol : AnyObject{
    
    static func createModule(selectedProducts:[LGPProduct]?)-> LGPOrderSummaryViewController
    func navigateToOrderSuccess(view : LGPOrderSummaryPresenterToViewProtocol?)
}

/**
 - LGPOrderSummaryPresenterToInteractorProtocol  - protocol methods used  for presenter to Interactor communication
 */
protocol LGPOrderSummaryPresenterToInteractorProtocol : AnyObject{
    var presenter:LGPOrderSummaryInteractorToPresenterProtocol? {get set}
    var selectedProducts : [LGPProduct]? { get set }
    // this method is used fetch LGPOrderElements from selected products
    func fetchOrderSummaryElements()
    // this method is used upadte LGPOrderElements
    func updateOrderAddress(index:Int , address: String)
    // this method is used fetch save ordersummary orderinfo json file
    func placeAnSelectedProducts()
    
}

/**
 - LGPOrderSummaryInteractorToPresenterProtocol  - protocol methods used  for  Interactor to presentercommunication
 */
protocol LGPOrderSummaryInteractorToPresenterProtocol : AnyObject {
    func fetchOrderSummaryElementsSuccess(orderedList:[LGPOrderElements]?)
    func updateOrderSummarySuccess(orderedList:[LGPOrderElements]?)
    func placeAnSelectedProductsSuccess()
    func placeAnSelectedProductsFailure()
}
