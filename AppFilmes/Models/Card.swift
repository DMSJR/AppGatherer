//
//  Card.swift
//  AppFilmes
//
//  Created by user on 14/07/23.
//

import Foundation
struct Legality:Decodable {
    let format : String?
    let legality : String?
}

struct Card: Decodable {
        let name : String
        let text : String?
        let imageUrl : String?
        let legalities :[Legality?]?
    }
    
   
    

