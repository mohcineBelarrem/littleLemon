//
//  MenuList.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import Foundation

struct MenuList: Decodable {
    let items: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case items = "menu"
    }
}
