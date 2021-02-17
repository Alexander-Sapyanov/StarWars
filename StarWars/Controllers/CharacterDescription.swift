//
//  CharacterDescription.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 16.02.2021.
//

import UIKit

class CharacterDescription: UIViewController {
    
    var infoTableView = UITableView()
    var data: [Character] = []
    var allChar = ["Name:","BirthYear:","EyeColor:","Gender:","HairColor:","Height:"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        }
    func setTableView() {
        view.addSubview(infoTableView)
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        infoTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 560).isActive = true
        infoTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        infoTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        infoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        infoTableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.identifier)
        infoTableView.dataSource = self
    }
}

// MARK: - Extensions
extension CharacterDescription: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier, for: indexPath) as! CharactersTableViewCell
        var info: [String] = []
        for i in data {
            let name = i.name
            let birthYear = i.birthYear
            let eyeColor = i.eyeColor
            let gender = i.gender
            let hairColor = i.hairColor
            let height = i.height
            info.append(contentsOf: [name,birthYear,eyeColor,gender,hairColor,height])
        }
        cell.titleLabel.text = info[indexPath.row]
        cell.nameLabel.text = allChar[indexPath.row]
        return cell
    }
}
