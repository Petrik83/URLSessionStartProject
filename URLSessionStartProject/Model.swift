//
//  Model.swift
//  URLSessionStartProject
//
//  Created by Alexey Pavlov on 29/11/21.
//

import Foundation
import FileProvider

struct Cards: Decodable {
        let cards: [Card]
}

struct Card: Decodable {
    let name: String
    let setName: String
    let names: [String]?
    let manaCost: String?
    let type: String?
    let rarity: String?
    let power: String?
}
