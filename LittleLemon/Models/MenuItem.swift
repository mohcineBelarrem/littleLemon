//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import Foundation

enum MenuItemCategory: String, CaseIterable, Identifiable {
    case starters
    case mains
    case desserts
    case drinks
    
    var id: String {
        return self.rawValue
    }
}

struct MenuItem: Identifiable, Codable {
    let id : Int
    let title: String
    let price: String
    let summary: String
    let category: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case summary = "description"
        case image
        case category
    }
}
