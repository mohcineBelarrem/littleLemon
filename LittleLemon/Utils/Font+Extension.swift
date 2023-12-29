//
//  Font+Extension.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 29/12/2023.
//

import Foundation
import SwiftUI


extension Font {
    
    static func markaziRegular(_ size: CGFloat) -> Font {
        return Font.custom("MarkaziText-Regular", size: size)
    }
    
    static func markaziBold(_ size: CGFloat) -> Font {
        return Font.custom("MarkaziText-Bold", size: size)
    }
    
    static func markaziSemiBold(_ size: CGFloat) -> Font {
        return Font.custom("MarkaziText-SemiBold", size: size)
    }
    
    static func markaziMedium(_ size: CGFloat) -> Font {
        return Font.custom("MarkaziText-Medium", size: size)
    }
    
    static func karlaMedium(_ size: CGFloat) -> Font {
        return Font.custom("Karla-Medium", size: size)
    }
    
    static func karlaRegular(_ size: CGFloat) -> Font {
        return Font.custom("Karla-Regular", size: size)
    }
    
    static func karlaBold(_ size: CGFloat) -> Font {
        return Font.custom("Karla-Bold", size: size)
    }
    
    static func karlaSemiBold(_ size: CGFloat) -> Font {
        return Font.custom("Karla-SemiBold", size: size)
    }
}
