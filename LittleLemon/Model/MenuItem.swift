//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import Foundation

enum MenuItemCategory: String {
    case starters
    case mains
    case desserts
}

struct MenuItem: Identifiable, Decodable {
    let id: UUID
    let title: String
    let price: String
    let description: String
    let category: MenuItemCategory
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case price
        case description
        case image
        case category
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.price = try values.decode(String.self, forKey: .price)
        self.image = try values.decode(String.self, forKey: .image)
        self.title = try values.decode(String.self, forKey: .title)
        self.description = try values.decode(String.self, forKey: .description)
        self.id = UUID()
        
        if let category = try? values.decode(String.self, forKey: .category), let menuCategory = MenuItemCategory(rawValue: category) {
            self.category = menuCategory
        } else {
            throw NSError()
        }
    }
}
