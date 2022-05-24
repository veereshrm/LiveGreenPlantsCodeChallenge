//
//  LGPOrderSummaryInteractor.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation

class LGPOrderSummaryInteractor : LGPOrderSummaryPresenterToInteractorProtocol {
    
    weak var presenter: LGPOrderSummaryInteractorToPresenterProtocol?
    var selectedProducts : [LGPProduct]?
    var summaryElements : [LGPOrderElements]?
    
    /**
     -  Function  used to fetchOrderSummaryElements
     */
    func fetchOrderSummaryElements(){
        if let products = selectedProducts {
            summaryElements = createOrderSummaryForProducts(products: products)
            presenter?.fetchOrderSummaryElementsSuccess(orderedList: summaryElements)
        }
        
    }
    
    /**
     -  Function  used to update address to model
     */
    func updateOrderAddress(index: Int, address: String) {
        summaryElements?[index].item = address
        presenter?.updateOrderSummarySuccess(orderedList: summaryElements)
        
    }
    
    /**
     - Private Function  used to create LGPOrderElements from Selected products
     */
    private func createOrderSummaryForProducts(products:[LGPProduct])->[LGPOrderElements]{
        var orderElements = [LGPOrderElements]()
        var total = 0
        for product in products {
            let orderElement = LGPOrderElements(item: product, type: .product)
            if let quantity = product.quantity {
                total += product.price * quantity
            }
            orderElements.append(orderElement)
        }
        orderElements.append(LGPOrderElements(item: total, type: .totalAmount))
        orderElements.append(LGPOrderElements(item: "", type: .address))
        return orderElements
    }
    
    /**
     - Function  used to place an order
     */
    func placeAnSelectedProducts() {
        var address = ""
        var amount = 0
        if let orderedSummary = summaryElements {
            for summary in orderedSummary {
                if summary.type == .address {
                    address = summary.item as? String ?? ""
                }
                else if summary.type == .totalAmount {
                    amount = summary.item as? Int ?? 0
                }
            }
        }
        let selectedProducts = LGPOrderSummmary(selectedProducts: self.selectedProducts, totalAmmount: amount, address: address)
        
        LGPNetworkLayer.writeJSONToFile(fileName: LGPFileName.orderFile.rawValue, type: selectedProducts){ [weak self](success,error) in
            if success == true {
                self?.presenter?.placeAnSelectedProductsSuccess()
            }
            else{
                self?.presenter?.placeAnSelectedProductsFailure()
            }
            
            
        }
        
    }
    
}
