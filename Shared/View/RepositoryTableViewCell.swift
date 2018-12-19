//
//  RepositoryTableViewCell.swift
//  ios-architecture-example
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    private let starLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    private let updatedDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 1.0)
        return view
    }()
    
    // MARK: - Con(De)structor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setProperties()
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(languageLabel)
        contentView.addSubview(starLabel)
        contentView.addSubview(updatedDateLabel)
        contentView.addSubview(lineView)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden: UITableViewCell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reset()
    }
    
    // MARK: - Public methods
    
    public func configure(with model: RepositoryModel) {
        titleLabel.text = model.full_name
        descriptionLabel.text = model.description
        languageLabel.text = model.language
        starLabel.text = "⭐️ \(model.stargazers_count)"
        updatedDateLabel.text = model.updated_at
    }
    
    // MARK: - Private methods
    
    private func reset() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        languageLabel.text = nil
        starLabel.text = nil
        updatedDateLabel.text = nil
    }
    
    private func setProperties() {
        selectionStyle = .gray
    }
    
}

// MARK: - Layout

extension RepositoryTableViewCell {

    private func layout() {
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        
        languageLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        languageLabel.trailingAnchor.constraint(equalTo: starLabel.leadingAnchor, constant: -64).isActive = true
        
        starLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        starLabel.topAnchor.constraint(equalTo: languageLabel.topAnchor).isActive = true
        
        updatedDateLabel.topAnchor.constraint(equalTo: starLabel.bottomAnchor, constant: 8).isActive = true
        updatedDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        updatedDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        updatedDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
}
