//
//  FilmTableViewCell.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 08.02.2021.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    static let identifire = "Cell"
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
    var caseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Functions
    func addViews() {
        addSubview(caseImageView)
        addSubview(nameLabel)
        caseImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        caseImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        caseImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        caseImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: caseImageView.bottomAnchor, constant: 5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.size.width).isActive = true
        
       
    }
}
