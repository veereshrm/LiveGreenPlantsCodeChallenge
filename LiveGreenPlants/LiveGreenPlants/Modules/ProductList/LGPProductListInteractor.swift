//
//  LGPProductListInteractor.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation

class LGPProductListInteractor : LGPProductListPresenterToInteractorProtocol {
 
    var products: [LGPProduct]?
    var stroreInfo: LGPStore?
    weak var presenter: LGPProductListInteractorToPresenterProtocol?

    /**
     - Function  used to fetch product list from Products.json
     */
    func fetchProductList() {
        LGPNetworkLayer.readJSONFromFile(fileName: LGPFileName.productFile.rawValue, type: [LGPProduct].self) {[weak self](response, error) in
            if error == nil {
                self?.products = response
                self?.presenter?.fetchProductListSuccess(products: self?.products)
            }
            else {
                self?.presenter?.fetchProductListFailure()
            }
            
        }
        
    }
    
    /**
     - Function  used to fetch product list from StoreInfo.json
     */
    func fetchStoreInfo() {
        LGPNetworkLayer.readJSONFromFile(fileName: LGPFileName.storeFile.rawValue, type: LGPStore.self){[weak self](response, error) in
            if error == nil {
                self?.stroreInfo = response
                self?.presenter?.fetchStoreInfoSuccess(stroreInfo: self?.stroreInfo)
            }
            else {
                self?.presenter?.fetchStoreInfoFailure()
            }
        }
        
    }
    
    /**
     - Function  used to fetch selected  products
     */
    func fetchSelectedProducts() {
        let selectedProducts = self.products?.filter {
            ($0.quantity ?? 0 > 0)
        }
        
        presenter?.fetchSelectedProductsSuccess(products: selectedProducts)
    }
    
    /**
     - Function  used to update  product quantity in product list
     - Parameter - index - product Index and isIncrement - boolean to indicate increment or decrement quantity
     */
    func updateProductListForQuatitySelection(on index: Int, isIncrement: Bool) {
        if let product = products?[index] {
            if isIncrement == true {
                if product.quantity ?? 0 < product.stock {
                    products?[index].quantity? += 1
                }
                
            }
            else {
                if product.quantity ?? 0 > 0 {
                    products?[index].quantity? -= 1
                }
                
            }

        }
        
        presenter?.updateProductListForQuatitySelectionSuccess(products: products)
    }
   
    
    
}
