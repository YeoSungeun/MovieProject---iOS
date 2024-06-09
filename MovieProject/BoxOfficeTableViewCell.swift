//
//  BoxOfficeTableViewCell.swift
//  MovieProject
//
//  Created by 여성은 on 6/10/24.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {
    
    let rankLabel = UILabel()
    let movieNmLabel = UILabel()
    let opendDtLabel = UILabel()
    
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
        contentView.addSubview(rankLabel)
        contentView.addSubview(movieNmLabel)
        contentView.addSubview(opendDtLabel)
    }
    func configureLayout() {
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(40)
        }
        movieNmLabel.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel.snp.centerY)
            make.leading.equalTo(rankLabel.snp.trailing).offset(16)
//            make.height.equalTo(32)
        }
        opendDtLabel.snp.makeConstraints { make in
            make.centerY.equalTo(movieNmLabel.snp.centerY)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
    }
    func configureUI() {
        contentView.backgroundColor = .black
        
        
        rankLabel.font = .boldSystemFont(ofSize: 17)
        rankLabel.textAlignment = .center
        
        movieNmLabel.textColor = .white
        movieNmLabel.font = .boldSystemFont(ofSize: 15)
        
        opendDtLabel.textColor = .white
        opendDtLabel.font = .systemFont(ofSize: 12)
        opendDtLabel.textAlignment = .right
        
    }

    func configureCell(data: DailyBoxOfficeList) {
        rankLabel.text = data.rank
        rankLabel.backgroundColor = (rankLabel.text != "") ? .white : .clear
        movieNmLabel.text = data.movieNm
        opendDtLabel.text = data.openDt
    }

}
