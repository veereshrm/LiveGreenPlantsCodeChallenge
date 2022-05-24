//
//  LGPFontAdditions.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 23/05/22.
//

import UIKit
extension UIFont {
    
    class func lgpBoldFontOfSize(_ fontSize: CGFloat) -> UIFont? {
        return self.init(name: "Helvetica-Bold", size: fontSize)
    }
    
    class func lgpMediumFontOfSize(_ fontSize: CGFloat) -> UIFont? {
        return self.init(name: "HelveticaNeue-Medium", size: fontSize)
    }
    
    class func lgpLightFontOfSize(_ fontSize: CGFloat) -> UIFont? {
        return self.init(name: "HelveticaNeue-Light", size: fontSize)
    }
    
}
