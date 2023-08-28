//
//  CardList.swift
//  AppGatherer
//
//  Created by user on 24/08/23.
//

import Foundation

struct CardStorage: Codable {
    var name: String
    var numberOfCopies: Int
    
    
}
class JSONManipulation{
    
        func createJSON(deck: [CardStorage]){
        
        let defaults = UserDefaults.standard
        let enconder = JSONEncoder()
        var savedList = deck
            if savedList.count > 1{
                savedList.sort{card1, card2 in
                    return card1.name >= card2.name}
            
                    for counter in 0 ..< (savedList.count - 1){
                    if savedList[counter].name == savedList[counter + 1].name{
                        savedList[counter + 1].numberOfCopies = savedList[counter].numberOfCopies + savedList[counter + 1].numberOfCopies
                        savedList[counter].name = ""
                    }
                    
                }
                savedList = savedList.filter{
                    $0.name != ""
                }}
        guard let data = try? enconder.encode(savedList) else {return}
        defaults.set(data , forKey:"cardStorage")
        
    }
    public func addJSON(listOfCards: [CardStorage]){
        var savedList = readJSON()
        savedList.append(contentsOf: listOfCards)
        savedList.sort{card1, card2 in
            return card1.name >= card2.name}
        for counter in 0 ..< (savedList.count - 1){
            if savedList[counter].name == savedList[counter + 1].name{
                savedList[counter + 1].numberOfCopies = savedList[counter].numberOfCopies + savedList[counter + 1].numberOfCopies 
                savedList[counter].name = ""
            }
            
        }
        savedList = savedList.filter{
            $0.name != ""
        }
        createJSON(deck: savedList)
        print (savedList)
    }
    
    public func readJSON()-> [CardStorage]{
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        guard let data = defaults.object (forKey:"cardStorage") as? Data    else{
            return []
        }
        if let cardList = try? decoder.decode([CardStorage].self, from: data){
            return cardList
        }
        return []
    }
    
    
}

