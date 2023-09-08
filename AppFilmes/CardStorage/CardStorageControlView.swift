//
//  CardStorageControleView.swift
//  AppGatherer
//
//  Created by user on 25/08/23.
//

import UIKit

class CardStorageControlView: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
  
    func setupView(){
        addViewsInHierarchy()
        setupConstraints()
    }
        
    func addViewsInHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(saveButton)
    }
    var textView: UITextView = {
        
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
        var textViewText : String = ""
        var cardsArray: [CardStorage] = CardViewController.jSONManipulation.readJSON()
        for card in cardsArray {
            textViewText += "\(card.numberOfCopies)x \(card.name)\n"
            
        }
        
        text.text = textViewText
        return text
    }()
    var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Editar inventario"
        title.backgroundColor = .white
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    lazy var saveButton: UIButton = {[weak self] in
        let save = UIButton()
        save.translatesAutoresizingMaskIntoConstraints = false
        save.setTitle("Salvar", for: .normal)
        save.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        save.setTitleColor(.white, for: .normal)
        save.backgroundColor = .black
        return save
    }()
    
    @objc func buttonTapped(_ sender: UIButton) {
        var cardsArray: [CardStorage] = []
        let textInput = textView.text
        var textSplitN:[String] = []
        if textInput != nil{
            textSplitN = textInput!.split(separator: "\n").map{ String($0) }
        }
        for index in 0 ..< textSplitN.count {
            
            let lineSplit = textSplitN[index].split(separator: "x ").map { String($0) }
            if let numberOfCopies = Int(lineSplit[0]){
                cardsArray.append(CardStorage(name: lineSplit[1], numberOfCopies: numberOfCopies))

            }
        }
        CardViewController.jSONManipulation.createJSON(deck: cardsArray)
        
        dismiss(animated: true, completion: nil)
        
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        ])
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: textView.bottomAnchor),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
    
}

