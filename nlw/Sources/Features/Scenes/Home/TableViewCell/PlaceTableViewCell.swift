//
//  PlaceTableViewCell.swift
//  nlw
//
//  Created by Niceplanet T.I on 23/12/24.
//

import Foundation
import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let indentifier = "PlaceTableViewCell"
    
    var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textSM
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = Typography.textSM
        description.numberOfLines = 0
        description.textColor = Colors.gray500
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    let ticketIcon: UIImageView = {
        let ticket = UIImageView()
        ticket.contentMode = .scaleAspectFit
        ticket.tintColor = Colors.redBase
        ticket.image = UIImage(named: "ticket")
        ticket.translatesAutoresizingMaskIntoConstraints = false
        
        return ticket
    }()
    
    let ticketLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textXS
        label.textColor = Colors.gray400
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.gray200.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(containerView)
        containerView.addSubview(itemImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(ticketIcon)
        containerView.addSubview(ticketLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            itemImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            itemImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 116),
            itemImageView.heightAnchor.constraint(equalToConstant: 104),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            ticketIcon.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16 ),
            ticketIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            ticketIcon.widthAnchor.constraint(equalToConstant: 13),
            ticketIcon.heightAnchor.constraint(equalToConstant: 11),
            
            ticketLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            ticketLabel.centerYAnchor.constraint(equalTo: ticketIcon.centerYAnchor),
            ticketLabel.leadingAnchor.constraint(equalTo: ticketIcon.trailingAnchor, constant: 4)
            
        ])
    }
    
    func configure(with place: Place){
        if let url  = URL(string: place.cover){
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.itemImageView.image = image
                    }
                }
            }.resume()
        }
        ticketLabel.text = place.name
        descriptionLabel.text = place.description
        ticketLabel.text = "\(place.coupons) cupons disponíveis"
    }
}
