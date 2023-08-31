//
//  DetailViewController.swift
//  AppFilmes
//
//  Created by user on 13/07/23.
//

import UIKit

class DetailViewController : UIViewController{
    
    
    var card: Card!
   
    
    
    
    @IBOutlet weak var cardName: UILabel!
    
   
    @IBOutlet weak var cardText: UITextView!
    
    @IBOutlet weak var cardLegality: UITextView!
    @IBOutlet weak var cardImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardImage.layer.cornerRadius = 8
        cardImage.layer.masksToBounds = true
        cardImage.contentMode = .scaleAspectFill
        cardImage.backgroundColor = .systemGray
        if card.imageUrl != nil{
            cardImage.downloadImage(path: card.imageUrl!)
        }
        cardName.text = card.name
        cardText.text = card.text
        var cardLegalities: String = ""
        if card.legalities != nil{
            for legality in card.legalities!{
                if legality != nil{
                    cardLegalities += legality!.format! + ": " + legality!.legality! + "\n"
                    
                    
                }
                cardLegality.text = cardLegalities
            }}
        
        
    }
    @IBAction func addCard(_ sender: UIButton) {
       
        var cardToBeStored: [CardStorage] = []
        
        cardToBeStored.append(CardStorage(name: card.name, numberOfCopies: 1))
            
            
        
        CardViewController.jSONManipulation.addJSON(listOfCards: cardToBeStored)
        //print(DetailViewController.jSONManipulation.readJSON())
        
    }
    
    
}
