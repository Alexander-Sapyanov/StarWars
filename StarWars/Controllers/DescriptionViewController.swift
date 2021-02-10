//
//  DescriptionViewController.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 10.02.2021.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    
    var data: Film?
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
    
    var posterImage = UIImageView()
    var nameLabel = UILabel()

    


    override func viewDidLoad() {
        super.viewDidLoad()
        
    

      
    
        view.backgroundColor = .white
        view.addSubview(backButton)
     
        
        
        
        
    }
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
    
    func setLabel(episodeName: String) {
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 30).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: posterImage.leftAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: posterImage.rightAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.text = episodeName
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    

   

}
