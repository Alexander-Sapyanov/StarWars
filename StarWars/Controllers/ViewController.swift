//
//  ViewController.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 08.02.2021.
//

import UIKit
import Alamofire
import AVKit

class ViewController: UIViewController {
    var filmsCollectionView: UICollectionView!
    var films: [Film] = []
    let imageForFilm = ["A New Hope",
                        "The Empire strikes back",
                        "Return of the Jedi",
                        "Phantom menace",
                        "Attack of the clones",
                        "Revenge of the sith"]
    var characters: [Character] = []
    
    // Video Play
    let videoPreviewLooper = VideoLooperView(videos: Video.localVideos())
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        fetchFilms()
        fetchCharacters()
        
        
        view.addSubview(videoPreviewLooper)
        videoPreviewLooper.frame = CGRect(x: 10 , y: 10, width: view.bounds.size.width - 10,height: 400)
        videoPreviewLooper.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        videoPreviewLooper.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoPreviewLooper.pause()
    }
    
    // MARK: - Functions
    func fetchFilms() {
        AF.request("https://swapi.dev/api/films")
            .validate().responseDecodable(of: Films.self) { (response) in
                guard let films = response.value else { return }
                self.films = films.all
                self.filmsCollectionView.reloadData()
            }
        
    }
    func fetchCharacters() {
        AF.request("https://swapi.dev/api/people/")
            .validate().responseDecodable(of: Characters.self) { (response) in
                guard let characters = response.value else { return }
                self.characters = characters.all
                print( characters.count)
           
            }
    }
    

    func createTableView() {
        let episodeLabel = UILabel()
        let frame = CGRect(x:0 , y: Int(view.bounds.size.height / 2 ), width: Int(view.bounds.size.width) , height: Int(view.bounds.size.height / 2)  )
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
     
        filmsCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        filmsCollectionView.dataSource = self
        filmsCollectionView.delegate = self
        filmsCollectionView.backgroundColor = .white
        
        episodeLabel.text = "Episodes"
        episodeLabel.textColor = .black
        episodeLabel.font = UIFont(name: "Starjedi", size: 40)
        episodeLabel.frame = CGRect(x: 10, y: 370, width: 220, height: 220)
    
        filmsCollectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.identifire)
        
        view.addSubview(filmsCollectionView)
        view.addSubview(episodeLabel)
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
