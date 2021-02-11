//
//  CharactersCollectionViewCell.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 10.02.2021.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CharacterCell"
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
    
        addViews()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func addViews() {
  
        addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.size.width).isActive = true

    }
    
    
    
}
