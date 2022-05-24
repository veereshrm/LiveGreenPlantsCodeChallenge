//
//  LGPNetworkLayer.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation

/**
 - enum  will indicate Error type
 */
enum LGPError {
    case unkown
    case writeError
    case readError
}

class LGPNetworkLayer {
    
    /**
     - static function   used to read json file
     - Parameter - filename , type of retrun object, completion handler
     */
    
    static func readJSONFromFile<T: Decodable>(fileName: String, type: T.Type , completion: @escaping (T?, LGPError?)->Void) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                completion(jsonData, nil)
            } catch {
                completion(nil, LGPError.readError)
            }
        }
    }
    
    /**
     - static function   used to write json data to file
     - Parameter - filename , type of  object, completion handler
     */
    static func writeJSONToFile<T: Encodable>(fileName: String, type: T, completion: @escaping (Bool, LGPError?)->Void) {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(fileName)
            fileURL = fileURL.appendingPathExtension("json")
            do {
                let jsonEncoder = JSONEncoder()
                let jsonResultData = try jsonEncoder.encode(type)
                try jsonResultData.write(to: fileURL, options: [.atomicWrite])
                completion(true,nil)
                
            } catch {
                completion(false,LGPError.writeError)
            }
        }
        
    }
    
    
    
    
    
}
