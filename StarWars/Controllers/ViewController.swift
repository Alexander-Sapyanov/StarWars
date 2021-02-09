//
//  ViewController.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 08.02.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    
    var filmsCollectionView: UICollectionView!
    var films: [Film] = []
    let imageForFilm = ["A New Hope","The Empire strikes back","Return of the Jedi","Phantom menace","Attack of the clones","Revenge of the sith"]
  

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        fetchFilms()
    }
    
    // MARK: - Functions
    func fetchFilms() {
        AF.request("https://swapi.dev/api/films")
            .validate().responseDecodable(of: Films.self) { (response) in
                guard let films = response.value else { return }
                self.films = films.all
                self.filmsCollectionView.reloadData()
                
                print(films.count)
            }
    }
    
    func createTableView() {
        let frame = CGRect(x:0 , y: Int(view.bounds.size.height / 2 ), width: Int(view.bounds.size.width) , height: Int(view.bounds.size.height / 2)  )
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        filmsCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        filmsCollectionView.dataSource = self
        filmsCollectionView.delegate = self
        filmsCollectionView.backgroundColor = .white
        
        
        filmsCollectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.identifire)
        view.addSubview(filmsCollectionView)
    }
}

    // MARK: - Extensions
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifire,for: indexPath) as! FilmCollectionViewCell
     
        cell.nameLabel.text = films[indexPath.row].title
        cell.caseImageView.image = UIImage(named: imageForFilm[indexPath.row])
        cell.layer.cornerRadius = 18
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}
