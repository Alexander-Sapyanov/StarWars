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
    var charactersTableView: UITableView!
    var films: [Film] = []
    var items: [Film] = []
    let imageForFilm = ["A New Hope",
                        "The Empire strikes back",
                        "Return of the Jedi",
                        "Phantom menace",
                        "Attack of the clones",
                        "Revenge of the sith"]
    var characters: [Character] = []
    
    var selectedItem: Film?
    var selectedChar: Character?
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
        fetchFilms()
        fetchCharacters()
        createTableView()
    }

    // MARK: - Functions
    func fetchFilms() {
        AF.request("https://swapi.dev/api/films")
            .validate().responseDecodable(of: Films.self) { (response) in
                guard let films = response.value else { return }
                self.films = films.all
                self.items = films.all
                self.filmsCollectionView.reloadData()
            }
    }
    
    func fetchCharacters() {
        AF.request("https://swapi.dev/api/people")
            .validate().responseDecodable(of: Characters.self) { (response) in
                guard let characters = response.value else { return }
                self.characters = characters.all
                self.charactersTableView.reloadData()
            }
    }

    func createCollectionView() {
        
        let frame = CGRect(x:0 , y: Int(view.bounds.size.height / 2 ), width: Int(view.bounds.size.width) , height: Int(view.bounds.size.height / 2)  )
        let episodeLabel = UILabel()
        episodeLabel.text = "Episodes"
        episodeLabel.textColor = .black
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeLabel.font = UIFont(name: "Starjedi", size: 40)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       
        filmsCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        filmsCollectionView.dataSource = self
        filmsCollectionView.delegate = self
        filmsCollectionView.backgroundColor = .white
        view.addSubview(filmsCollectionView)
        view.addSubview(episodeLabel)
        
        filmsCollectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.identifire)
        
        NSLayoutConstraint.activate([
            episodeLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            episodeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            episodeLabel.widthAnchor.constraint(equalTo: episodeLabel.widthAnchor)
        ])
        
    
    }
    func createTableView() {

        let charactersLabel = UILabel()
        charactersLabel.translatesAutoresizingMaskIntoConstraints = false
        charactersLabel.text = "Characters"
        charactersLabel.textColor = .red
        charactersLabel.backgroundColor = .black
        charactersLabel.font = UIFont(name: "Starjedi", size: 40)

        charactersTableView = UITableView()
        view.addSubview(charactersTableView)
        view.addSubview(charactersLabel)
        
        charactersTableView.backgroundColor = .black
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        charactersTableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.identifier)
    
        NSLayoutConstraint.activate([
            charactersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            charactersLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            charactersLabel.widthAnchor.constraint(equalTo: charactersLabel.widthAnchor),
            
            charactersTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            charactersTableView.topAnchor.constraint(equalTo: charactersLabel.bottomAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: filmsCollectionView.topAnchor),
            charactersTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

    // MARK: - Extensions
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifire,for: indexPath) as! FilmCollectionViewCell
        let item = items[indexPath.row]
        cell.nameLabel.text = item.title
        cell.caseImageView.image = UIImage(named: imageForFilm[indexPath.row])
        cell.layer.cornerRadius = 18
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = films[indexPath.row]
        let vc = DescriptionViewController()
        vc.data.append(selectedItem!)
        vc.setPosterImage(imageName: imageForFilm[indexPath.row])
        vc.set(episodeName: selectedItem!.title)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - Extensions
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDescription()
        selectedChar = characters[indexPath.row]
        
        vc.data.append(selectedChar!)
        present(vc, animated: true, completion: nil)
    }
}


