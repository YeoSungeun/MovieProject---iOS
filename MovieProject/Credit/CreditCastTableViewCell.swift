//
//  CastTableViewCell.swift
//  MovieProject
//
//  Created by 여성은 on 6/30/24.
//

import UIKit
import SnapKit

final class CreditCastTableViewCell: UITableViewCell {
    
    let castImageView = UIImageView()
    let nameLabel = UILabel()
    let charactorLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureHierarchy() {
        contentView.addSubview(castImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(charactorLabel)
    }
    func configureLayout() {
        castImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(100)
            make.width.equalTo(80)
            make.verticalEdges.equalTo(contentView).inset(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(castImageView.snp.centerY).offset(-4)
            make.leading.equalTo(castImageView.snp.trailing).offset(12)
            make.height.equalTo(20)
        }
        charactorLabel.snp.makeConstraints { make in
            make.top.equalTo(castImageView.snp.centerY).offset(4)
            make.leading.equalTo(castImageView.snp.trailing).offset(12)
            make.height.equalTo(20)
        }
    }
    func configureUI() {
        castImageView.clipsToBounds = true
        castImageView.contentMode = .scaleAspectFill
        castImageView.layer.cornerRadius = 5
        nameLabel.font = .boldSystemFont(ofSize: 14)
        charactorLabel.font = .systemFont(ofSize: 13)
        charactorLabel.textColor = .gray
    }
    func configureCell(data: CastResult ) {
        if let path = data.profile_path {
            castImageView.setImageView(path: path)
        }
        nameLabel.text = data.name
        charactorLabel.text = data.character
         
    }
}
