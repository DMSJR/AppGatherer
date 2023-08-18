//
//  ViewController.swift
//  AppFilmes
//
//  Created by user on 07/07/23.
//

import UIKit

class CardViewController: UIViewController, UITableViewDataSource {
    
    
    
    private var cards: [Card] = []
            
    
    

    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Magic: the Gathering DB"
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    
    private let tableView : UITableView = {
        let table = UITableView()
        
        table.backgroundColor = UIColor.clear
        table.backgroundView = nil
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .white
        fetchRemoteCards()
        addViewsInHierarchy()
        setupConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        setBackgroundImage()
    }

    private func setBackgroundImage(){
        let backgroundImage = UIImage(named: "background.jpg")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
    }
    private func addViewsInHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
            ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
       	     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func fetchRemoteCards(){
        let url = URL(string: "http://api.magicthegathering.io/v1/cards")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            if error != nil { return}
            guard let cardsData = data else {return}
            let decoder = JSONDecoder()
           // print (String(data: cardsData, encoding: .utf8))
            guard let remoteCards = try? decoder.decode(MTGRemoteCards.self, from: cardsData) else {
                print("Erro")
                return}
            
            
            self.cards = remoteCards.cards.filter{$0.imageUrl != nil}
            

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
        
        
    }
}
extension CardViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CardCell()
        let card = cards[indexPath.row]
        
        cell.setup(card: card)
       
        cell.backgroundColor = UIColor.clear
            //        cell.textLabel?.text = cards[indexPath.row].name
            //        cell.textLabel?.textColor = UIColor.white
            //        cell.textLabel?.textAlignment = .center
            //        cell.textLabel?.shadowColor = UIColor.black
            //
            //        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            
                
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: Bundle(for: DetailViewController.self))
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        detailViewController.card = cards[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
        
        
    }
}
