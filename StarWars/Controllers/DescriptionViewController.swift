//
//  DescriptionViewController.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 10.02.2021.
//

import UIKit
import Alamofire

class DescriptionViewController: UIViewController {
    
    var data: [Film] = []
    let titles = ["Title:","Director:","Producer:","Release Date:"]
    var infoTableView = UITableView()
    var posterImage = UIImageView()
    var nameLabel = UILabel()
    var charactersInFilm: [Character?] = []
    var charactersCollectionView: UICollectionView?
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton2"), for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.textColor = .black
        button.frame = CGRect(x: 10, y: 30, width: 100, height: 100)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(goBack), for: .touchDown)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backButton)
    }
    
    // MARK: - Functions
    func setPosterImage(imageName: String) {
        view.addSubview(posterImage)
        posterImage.backgroundColor = .red
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.topAnchor.constraint(equalTo: view.topAnchor,constant: 140).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 2).isActive = true
        posterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        posterImage.contentMode = .scaleToFill
        posterImage.layer.cornerRadius = 18
        posterImage.clipsToBounds = true
        posterImage.image = UIImage(named: imageName)
    }
    
    func set(episodeName: String) {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: posterImage.leftAnchor, constant: -30).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 30).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.text = episodeName
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Starjedi", size: 18)
        
        view.addSubview(infoTableView)
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        infoTableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        infoTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        infoTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        infoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170).isActive = true
        infoTableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        infoTableView.dataSource = self
    }
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extensions
extension DescriptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as! FilmTableViewCell
        
        var info: [String] = []
        for i in data {
            let title = i.title
            let director = i.director
            let producer = i.producer
            let release = i.releaseDate
            info.append(contentsOf: [title, director, producer, release])
        }
        cell.nameLabel.text = titles[indexPath.row]
        cell.titleLabel.text = info[indexPath.row]
        return cell
    }
}


