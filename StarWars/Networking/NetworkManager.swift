//
//  Networking.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 11.02.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func fetchFilms(collectionView: UICollectionView) -> [Film]{
        AF.request("https://swapi.dev/api/films")
            .validate().responseDecodable(of: Films.self) { (response) in
                guard let films = response.value else { return }
              
                collectionView.reloadData()
                
            }
        // можно вынести в отдельный класс нетворкинг для запроса
    }
    
}
