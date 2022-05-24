//
//  LGPProductListInteractor.swift
//  LiveGreenPlantsTests
//
//  Created by Veeresh on 24/05/22.
//

import XCTest
@testable import LiveGreenPlants

class LGPProductListInteractorTest: XCTestCase {
    
    

    override func setUp() {
        
    }
    
    func test_fetchProductList() {
    
        let expectation = XCTestExpectation(description: "Products has been downloaded!")
        var products = [LGPProduct]()
        
        LGPNetworkLayer.readJSONFromFile(fileName: LGPFileName.productFile.rawValue, type: [LGPProduct].self) {(response, error) in
            if error == nil {
                products = response ?? [LGPProduct]()
                expectation.fulfill()
            }
            else {
                XCTFail()
            }
            
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(products.count > 0)
       
    }
    
    

}
