//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by James Hill on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit


class CardController {
    
    //MARK: String Constants
    static let mainURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    //MARK Fuctions
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        //URL
        guard let mainURL = mainURL else {return completion(.failure(.invalidURL))}
        print(mainURL)
        
        //Contact Server
        URLSession.shared.dataTask(with: mainURL) { data, response, error in
            
            //Handling Errors
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("CARD STATUS HERE: \(response.statusCode)")
            }
            
            //JSON
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                
                guard let card = topLevelObject.cards.first else {return completion(.failure(.noData))}
                completion(.success(card))
                
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        
        let cardImage = card.image
        
        URLSession.shared.dataTask(with: cardImage) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("Card Status Code: \(response.statusCode)")
                }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(image))
            
        }.resume()
    }
}//ZEnd of class
