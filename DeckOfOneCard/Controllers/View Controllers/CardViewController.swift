//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by James Hill on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var cardLabel: UILabel!
    
    
    //MARK: Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: Properties
    
    
    //MARK: Actions
    
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        
        CardController.fetchCard { [weak self]  (result) in
            
            DispatchQueue.main.async {
                
                
                
                switch result {
                case .success(let card):
                    self?.fetchImageandUpdateViews(for: card)
                case .failure(let error):
                    
                    self?.presentErrorToUser(localizedError: error)
                    
                }
            }
        }
    }
    
    func fetchImageandUpdateViews(for card: Card) {
        
        CardController.fetchImage(for: card) { [weak self] result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let image):
                    self?.cardImage.image = image
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                    
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}//End of Class

