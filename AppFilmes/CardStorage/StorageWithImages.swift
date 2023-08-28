//
//  StorageWithImages.swift
//  AppGatherer
//
//  Created by user on 28/08/23.
//

import UIKit
class StorageWithImagesViewController: UIViewController, UITableViewDataSource {
    
    var cards : [Card] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        setupView()
//    }

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Inventario"
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    
    private let inventoryButtonView : UIButton = {
        let inventoryButton = UIButton (type: .system)
        
        inventoryButton.setTitleColor(.black, for: .normal)
        inventoryButton.translatesAutoresizingMaskIntoConstraints = false
        inventoryButton.backgroundColor = .white
        inventoryButton.setTitle("Editar Inventario", for: . normal)
        inventoryButton.addTarget(self, action: #selector(openInventory), for: .touchUpInside)
        return inventoryButton
    }()
    @objc func openInventory(){
        let inventoryViewControl = CardStorageControlView()
        self.present(inventoryViewControl, animated: true, completion: nil)
    }
    private let tableView : UITableView = {
        let table = UITableView()
        
        table.backgroundColor = UIColor.clear
        table.backgroundView = nil
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private func setupView(){
        view.backgroundColor = .white
        fetchInventory(cardstorage: DetailViewController.jSONManipulation.readJSON())
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
        view.addSubview(inventoryButtonView)
        view.addSubview(tableView)
        
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ])
        
        
        
        NSLayoutConstraint.activate([
            inventoryButtonView.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant: 8),
            inventoryButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inventoryButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: inventoryButtonView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func fetchInventory(cardstorage: [CardStorage]){
        if !cardstorage.isEmpty{
            var url : URL
            print (cardstorage)
            for card in cardstorage{
                
                var cardNameWithoutSpaces: String
                cardNameWithoutSpaces = card.name.replacingOccurrences(of: " ", with: "_")
        
                url = URL (string: ("http://api.magicthegathering.io/v1/cards?name=") + cardNameWithoutSpaces)!
                var request = URLRequest(url: url)
                var task = URLSession.shared.dataTask(with: request){data, _, error in
                    if error != nil {return}
                    guard var cardsData = data else {return}
                   // print (String(data: cardsData, encoding: .utf8))
                    var decoder = JSONDecoder()
                    guard var remoteCards = try? decoder.decode(MTGRemoteCards.self, from: cardsData)else{
                        print ("Erro")
                        return}
                    
                    self.cards.append(remoteCards.cards[0])
                   // print (self.cards)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                task.resume()
                }
               
            
        }
    }}
    
extension StorageWithImagesViewController: UITableViewDelegate{
    func searchForCard(card: Card) -> CardStorage{
        for cardToSeek in DetailViewController.jSONManipulation.readJSON(){
            if card.name == cardToSeek.name{
                return cardToSeek
            }
        }
            
        return CardStorage(name: "", numberOfCopies: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = InventoryCardCell()
        let card = cards[indexPath.row]
        
        
        cell.setup(card: card, cardStorage: searchForCard(card: card))
        
        cell.backgroundColor = UIColor.clear
            
                
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: Bundle(for: DetailViewController.self))
        let detailViewController1 = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        detailViewController1.card = cards[indexPath.row]
        navigationController?.pushViewController(detailViewController1, animated: true)
        
        
    }
}
