//
//  LGPProductListPresenter.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation
import UIKit

class LGPProductListPresenter : LGPProductListViewToPresenterProtocol {
  
    weak var view: LGPProductListPresenterToViewProtocol?
    var interactor: LGPProductListPresenterToInteractorProtocol?
    var router: LGPProductListPresenterToRouterProtocol?
    var selectedIndexPath : IndexPath = IndexPath()
    let numberOfSections = 2
    
    var  products : [LGPProduct]?
    var stroreInfo : LGPStore?
    
    // MARK: initial methods
    func didUpdateSubViews() {
        startFetchingStoreInfo()
    }
    
    func registerTableWithCell(tabelView: UITableView) {
        
        tabelView.register(UINib(nibName: "LGPProductCell", bundle: nil), forCellReuseIdentifier: "productCell")
    }
    
    /**
     - Function  used to get formatted price string
     - Parameter - price - product  price and currency - currency type
     - Return -  String
     */
    func getPriceText(price:Int, currency: LGPCurrency) -> String {
        switch currency {
        case .inr:
            return "Price : ₹\(price)"
        case .usd:
            return "Price : \(price)$"
        }
    }
    
    // MARK: TableView helper methods
    /**
     - helper methods will call with respect to update table view from view
     */
    
    func numberOfSectionInTable() -> Int {
        return numberOfSections
    }
    
    func numberOfRowsInSection() -> Int {
        return products?.count ?? 0
    }
    
    func getCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> LGPProductCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! LGPProductCell
        if let  product = self.products?[indexPath.row] {
            cell.productImageView.image = UIImage(named: product.image)
            cell.productTitleLabel.text = product.title
            cell.productPriceLabel.text = getPriceText(price: product.price, currency: product.currency)
            cell.productQuantityLabel.text = "\(product.quantity ?? 0)"
            if product.quantity ?? 0 < product.stock && product.quantity ?? 0 > 0{
                cell.quantityIncrementButton.isEnabled = true
                cell.quantityDecrementButton.isEnabled = true
                cell.quantityDecrementButton.tintColor =  lgpButtonColour
                cell.quantityIncrementButton.tintColor =  lgpButtonColour
            }
            else if product.quantity ?? 0 < product.stock && product.quantity ?? 0 == 0 {
                cell.quantityIncrementButton.isEnabled = true
                cell.quantityDecrementButton.isEnabled = false
                cell.quantityDecrementButton.tintColor =  lgpButtonGrayColour
                cell.quantityIncrementButton.tintColor =  lgpButtonColour
            }
            else {
                cell.quantityIncrementButton.isEnabled = false
                cell.quantityDecrementButton.isEnabled = true
                cell.quantityDecrementButton.tintColor =  lgpButtonColour
                cell.quantityIncrementButton.tintColor =  lgpButtonGrayColour
            }
            
            
        }
       
        
        return cell
    }
    
    // MARK: updateStoreInfoSection
    func updateStoreInfoSection(logoImage: UIImageView, infoLabel: UILabel) {
        if let storedetails = stroreInfo {
            logoImage.image = UIImage(named: storedetails.logo)
            infoLabel.attributedText =  getAttributedStoreInformation()
        }
       
    }
    
    // MARK: getAttributedStoreInformation
    func getAttributedStoreInformation()->NSMutableAttributedString {
        
        var storeInfo = NSMutableAttributedString()
        if let store = stroreInfo {
            let titleAttribute = [NSAttributedString.Key.font : lgpTitleFont, NSAttributedString.Key.foregroundColor : lgpTextColour]
            let subTitleAttribute = [NSAttributedString.Key.font : lgpSubTitleFont, NSAttributedString.Key.foregroundColor : lgpTextColour]
             storeInfo = NSMutableAttributedString(string: store.name + "\n", attributes: titleAttribute as [NSAttributedString.Key : Any])
            let storeTime = NSMutableAttributedString(string: "Timing :\(store.time)\n", attributes: subTitleAttribute as [NSAttributedString.Key : Any])
            let storePhone = NSMutableAttributedString(string: "Ph:\(store.phone)\n", attributes: subTitleAttribute as [NSAttributedString.Key : Any])
            let storeEmail = NSMutableAttributedString(string: "Email:\(store.email)\n", attributes: subTitleAttribute as [NSAttributedString.Key : Any])
            storeInfo.append(storeTime)
            storeInfo.append(storePhone)
            storeInfo.append(storeEmail)
            
        }
        return storeInfo
        
    }
    
    // MARK: startFetchingStoreInfo
    func startFetchingStoreInfo() {
        interactor?.fetchStoreInfo()
    }
    
    // MARK: startFetchingProductList
    func startFetchingProductList() {
        interactor?.fetchProductList()
    }
    
    // MARK: handleQuantitySelection
    func handleQuantitySelection(incrementButton:UIButton, tableView:UITableView, isIncrement:Bool){
        // sender.isSelected = !sender.isSelected
        let buttonPosition:CGPoint = incrementButton.convert(CGPoint.zero, to:tableView)
        if let indexPath = tableView.indexPathForRow(at: buttonPosition){
            selectedIndexPath =  indexPath
            interactor?.updateProductListForQuatitySelection(on: indexPath.row, isIncrement: isIncrement)
        }
    }
    
    // MARK: isProductsSelected
    func isProductsSelected()->Bool{
        let selectedProducts = self.products?.filter {
            ($0.quantity ?? 0 > 0)
        }
        return selectedProducts?.count ?? 0 > 0 ? true : false
    }
    
    // MARK: navigateToOrderSummary
    func navigateToOrderSummary() {
        interactor?.fetchSelectedProducts()
    }
    
    

}

// MARK: LGPProductListInteractorToPresenterProtocol methods
extension LGPProductListPresenter : LGPProductListInteractorToPresenterProtocol {
    
    func updateProductListForQuatitySelectionSuccess(products: [LGPProduct]?) {
        self.products = products
        view?.refresh(indexPath: selectedIndexPath)
        view?.enableViewSummaryButton(isEnable: isProductsSelected())
        
    }
    
    func fetchSelectedProductsSuccess(products: [LGPProduct]?) {
        router?.navigateToOrderSummary(view: view, productList: products)
    }
    
    func fetchProductListSuccess(products: [LGPProduct]?) {
        self.products = products
        view?.showFetchProductListSuccess()
        view?.enableViewSummaryButton(isEnable: isProductsSelected())
    }
    
    func fetchStoreInfoSuccess(stroreInfo: LGPStore?) {
        self.stroreInfo = stroreInfo
        startFetchingProductList()
        view?.showFetchStoreInfoSuccess()
    }
    
    func fetchProductListFailure() {
        view?.showFetchProductListFailure()
    }
    
    func fetchStoreInfoFailure() {
        view?.showFetchStoreInfoFailure()
    }
    
    
}
