//
//  LGPConstants.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation
import UIKit

var mainstoryboard: UIStoryboard{
    let bundle = Bundle.init(for: LGPProductListViewController.self)
    return UIStoryboard(name:"Main",bundle: bundle)
}

func LGPRGBCOLOR(rgbValue: Any, alpha:CGFloat=1.0) -> UIColor {
    return UIColor(red: CGFloat((Float(((rgbValue as? Int)! & 0x00ff0000) >> 16)) / 0xff), green: CGFloat((Float(((rgbValue as? Int)! & 0x0000ff00) >> 8)) / 0xff), blue: CGFloat((Float(((rgbValue as? Int)! & 0x000000ff) >> 0)) / 0xff), alpha: alpha)
}

let lgpHeaderFont = UIFont.lgpBoldFontOfSize(24)
let lgpSubHeaderFont = UIFont.lgpBoldFontOfSize(16)
let lgpTitleFont = UIFont.lgpMediumFontOfSize(16)
let lgpSubTitleFont = UIFont.lgpMediumFontOfSize(14)
let lgpLightFont = UIFont.lgpMediumFontOfSize(26)
let lgpSubLightFont = UIFont.lgpMediumFontOfSize(14)

let lgpButtonColour = LGPRGBCOLOR(rgbValue: 0x44c3a1)
let lgpButtonGrayColour = LGPRGBCOLOR(rgbValue: 0x9ca09d)
let lgpTextColour = LGPRGBCOLOR(rgbValue: 0x405566)
let lgpButtonTextColour = LGPRGBCOLOR(rgbValue: 0xFFFFFF)


