//
//  Card.swift
//  DeckOfOneCard
//
//  Created by James Hill on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

struct Card: Decodable {
    
    let value: String
    let suit: String
    let image: URL
    
    enum CodingKeys: String, CodingKey {
        case value
        case suit
        case image
    }

}//Enfo Struct


    
    struct TopLevelObject: Decodable {
        
        let cards: [Card]
        
        enum CodingKeys: String, CodingKey {
            
            case cards
        
    }

}//End of Struct

