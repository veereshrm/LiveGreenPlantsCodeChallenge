//
//  LGPOrderSummaryPresenter.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation
import UIKit

class LGPOrderSummaryPresenter : LGPOrderSummaryViewToPresenterProtocol {
    
    var summaryElements : [LGPOrderElements]?
    weak var view: LGPOrderSummaryPresenterToViewProtocol?
    var interactor: LGPOrderSummaryPresenterToInteractorProtocol?
    var router: LGPOrderSummaryPresenterToRouterProtocol?
    
    func didUpdateSubViews() {
        interactor?.fetchOrderSummaryElements()
    }
    
    private func getPriceText(price:Int, currency: LGPCurrency, title:String = "Price") -> String {
        switch currency {
        case .inr:
            return "\(title) : ₹\(price)"
        case .usd:
            return "\(title): \(price)$"
        }
    }
    
    private func getAttributedStoreInformation(product:LGPProduct?)->NSMutableAttributedString {
        
        var productAttribute = NSMutableAttributedString()
        if let productInfo = product {
            let titleAttribute = [NSAttributedString.Key.font : lgpTitleFont, NSAttributedString.Key.foregroundColor : lgpTextColour]
            let subTitleAttribute = [NSAttributedString.Key.font : lgpSubTitleFont, NSAttributedString.Key.foregroundColor : lgpTextColour]
            productAttribute = NSMutableAttributedString(string: productInfo.title + "\n", attributes: titleAttribute as [NSAttributedString.Key : Any])
            let quantity = NSMutableAttributedString(string: "Qty :\(productInfo.quantity ?? 0)\n", attributes: subTitleAttribute as [NSAttributedString.Key : Any])
            let cost = getPriceText(price: productInfo.price, currency: productInfo.currency)
            let price = NSMutableAttributedString(string: "Price:\(cost)\n", attributes: subTitleAttribute as [NSAttributedString.Key : Any])
            productAttribute.append(quantity)
            productAttribute.append(price)
        
            
        }
        return productAttribute
        
    }
    
    // MARK: TableView helper methods
    func numberOfRowsInSection() -> Int {
        return summaryElements?.count ?? 0
    }
    
    func getCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let summaryElement = self.summaryElements?[indexPath.row] {
            switch summaryElement.type {
            case .product:
                let cell = tableView.dequeueReusableCell(withIdentifier: "productSummaryCell", for: indexPath) as! LGPProductSummaryCell
                cell.productImageView.image = UIImage(named: (summaryElement.item as? LGPProduct)?.image ?? "")
                cell.productSummaryLabel.attributedText = getAttributedStoreInformation(product: summaryElement.item as? LGPProduct)
                return cell
                
            case .totalAmount:
                let cell = tableView.dequeueReusableCell(withIdentifier: "totalAmountCell", for: indexPath) as UITableViewCell
                if let amount = summaryElement.item as? Int {
                    cell.textLabel?.font = lgpHeaderFont
                    cell.textLabel?.textColor = lgpTextColour
                    cell.textLabel?.numberOfLines = 0
                
                    cell.textLabel?.text = getPriceText(price: amount, currency: .inr, title: "Total Amount to pay is:")
                }
                return cell
            case .address:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! LGPAddressCell
                cell.addressTextView.delegate = view as? UITextViewDelegate
                return cell
            }
            
        }
        return LGPProductCell()
    }
    
    func registerTableWithCell(tabelView: UITableView) {
        tabelView.register(UINib(nibName: "LGPAddressCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        tabelView.register(UINib(nibName: "LGPProductSummaryCell", bundle: nil), forCellReuseIdentifier: "productSummaryCell")
        tabelView.register(UITableViewCell.self, forCellReuseIdentifier: "totalAmountCell")
    }
    
    // MARK: Handle Address field editing
    func handleTextViewEndEditing(textView:UITextView, tableView:UITableView)  {
        let buttonPosition:CGPoint = textView.convert(CGPoint.zero, to:tableView)
        if let indexPath = tableView.indexPathForRow(at: buttonPosition){
            interactor?.updateOrderAddress(index: indexPath.row, address: textView.text)
        }
    }
    
    func placeAnOrder() {
        interactor?.placeAnSelectedProducts()
    }
    
    private func isAddressEmpty()->Bool{
        var isEmpty = false
        if let addressElement = summaryElements?.last {
            if addressElement.type == .address {
                if let value = addressElement.item as? String {
                    isEmpty = !value.isEmptyOrWhitespace()
                }
            }
        }
        
        return isEmpty
    }
    
    
    
    
}


extension LGPOrderSummaryPresenter : LGPOrderSummaryInteractorToPresenterProtocol {
    func placeAnSelectedProductsFailure() {
        //inform view to Present failure message
    }
    
    func placeAnSelectedProductsSuccess() {
        router?.navigateToOrderSuccess(view: view)
    }
    
    func updateOrderSummarySuccess(orderedList: [LGPOrderElements]?) {
        summaryElements = orderedList
        view?.enablePlaceOrderButton(isEnable: isAddressEmpty())
    }
    
    func fetchOrderSummaryElementsSuccess(orderedList: [LGPOrderElements]?) {
        summaryElements = orderedList
        view?.reloadSubviews()
        view?.enablePlaceOrderButton(isEnable: isAddressEmpty())
    }
    
    
    
}




