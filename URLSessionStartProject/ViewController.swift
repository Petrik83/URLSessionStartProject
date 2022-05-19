//
//  ViewController.swift
//  URLSessionStartProject
//
//  Created by Alexey Pavlov on 29.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let endpointClient = EndpointClient(applicationSettings: ApplicationSettingsService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        executeCall()
    }
    
    func executeCall() {
        let endpoint = GetNameEndpoint()
        let completion: EndpointClient.ObjectEndpointCompletion<Cards> = { result, response in
            
            guard let responseUnwrapped = response else { return }
            print("\n\n status code = \(responseUnwrapped.statusCode) \n")
            
            switch result {
            case .success(let team):
                for card in team.cards {
                    print("\nИмя карты: \(card.name)")
                    print("Название сета: \(card.setName)")
                    if let type = card.type {
                        print("Тип: \(type)")
                    }
                    if let manaCost = card.manaCost {
                        print("Мановая стоимость: \(manaCost)")
                    }
                    if let rarity = card.rarity {
                        print("Редкость карты: \(rarity)")
                    }
                    if let power = card.power {
                        print("Сила карты: \(power)")
                    }
                    if let names = card.names {
                        print("Все имена на карте: \(names)")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        endpointClient.executeRequest(endpoint, completion: completion)
    }
}

final class GetNameEndpoint: ObjectResponseEndpoint<Cards> {
    
    override var method: RESTClient.RequestType { return .get }
    override var path: String { "/v1/cards" }
    //    override var queryItems: [URLQueryItem(name: "id", value: "1")]?
    
    override init() {
        super.init()
        
        queryItems = [URLQueryItem(name: "name", value: "Black Lotus")]
    }
    
}











func decodeJSONOld() {
    let str = """
        {\"team\": [\"ios\", \"android\", \"backend\"]}
    """
    
    let data = Data(str.utf8)
    
    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let names = json["team"] as? [String] {
                print(names)
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
}

