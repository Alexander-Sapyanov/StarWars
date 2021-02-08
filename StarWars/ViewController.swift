//
//  ViewController.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 08.02.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var filmsTableView: UITableView!
    
    var films: [Film] = []
  

    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        fetchFilms()
    }
    func fetchFilms() {
        AF.request("https://swapi.dev/api/films")
            .validate().responseDecodable(of: Films.self) { (response) in
                guard let films = response.value else { return }
                self.films = films.all
                self.filmsTableView.reloadData()
                
                print(films.count)
            }
    }
    
    func createTableView() {
        filmsTableView = UITableView()
        filmsTableView.dataSource = self
        filmsTableView.frame = view.frame
        filmsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(filmsTableView!)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        let item = films[indexPath.row]
        cell.backgroundColor = .red
        cell.textLabel?.text = item.title
        return cell
    }
    
    
}

