//
//  LGPNetWorkLayerTest.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 24/05/22.
//

import XCTest
@testable import LiveGreenPlants

class LGPNetWorkLayerTest: XCTestCase {
    
    func test_readFile(){
        let expectation = XCTestExpectation(description: "Products has been downloaded!")
        var products = [LGPProduct]()
        if let url = Bundle.main.url(forResource: LGPFileName.productFile.rawValue, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                products = try decoder.decode([LGPProduct].self, from: data)
                expectation.fulfill()
               
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(products.count > 0)
    }

}
