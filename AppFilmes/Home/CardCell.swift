//
//  StackViewController.swift
//  AppFilmes
//
//  Created by user on 13/07/23.
//
import UIKit
class CardCell: UITableViewCell{
    
    
    
    
    
    
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        
        stack.layer.cornerRadius = 10
        
        stack.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        return stack
    }()
        private var nameStack: UIStackView = {
            let name = UIStackView()
            name.axis = .vertical
            name.translatesAutoresizingMaskIntoConstraints = false
            name.spacing = 8
            
            return name
        }()
        private var cardImageStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.spacing = 8
            stack.alignment = .center
            return stack
        }()
        private var cardImageView: UIImageView = {
            let image = UIImageView()
            
            image.translatesAutoresizingMaskIntoConstraints = false
            image.layer.cornerRadius = 18
            image.layer.masksToBounds = true
            image.backgroundColor = .systemGray
            
            return image
        }()
        
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.numberOfLines = 0
            label.textAlignment = .center
            
            return label
        }()
        
        //    private let setLabel: UILabel = {
        //        let label = UILabel()
        //        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        //        label.textColor = .white
        //        label.numberOfLines = 0
        //        return label
        //    }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupStackView()
            addViewsInHierarchy()
            setupConstraints()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }
        
        private func setupStackView(){
            selectionStyle = .none
            
        }
        
        public func setup(card: Card){
            
            nameLabel.text = card.name
            if card.imageUrl != nil{
                cardImageView.downloadImage(path: card.imageUrl!)
            }
            
        }
        private func addViewsInHierarchy(){
            contentView.addSubview(horizontalStack)
            nameStack.addArrangedSubview(nameLabel)
            cardImageStackView.addArrangedSubview(cardImageView)
            horizontalStack.addArrangedSubview(nameStack)
            horizontalStack.addArrangedSubview(cardImageStackView)
        }
        
        
        private func setupConstraints(){
            
            NSLayoutConstraint.activate([
                horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16 ),
                //horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 128),
                //horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -128)
                
            ])
            horizontalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            
            NSLayoutConstraint.activate([
                cardImageView.widthAnchor.constraint(equalToConstant:  200),
                cardImageView.heightAnchor.constraint(equalToConstant: 320)
                
            ])
//            NSLayoutConstraint.activate([
//                cardImageStackView.leadingAnchor.constraint(equalTo: horizontalStack.leadingAnchor, constant: 8),
//                cardImageStackView.trailingAnchor.constraint(equalTo: horizontalStack.trailingAnchor, constant: -8),
//                cardImageStackView.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 8),
//                cardImageStackView.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: -8)])
            
            
            
        }	
    }

