//
//  TrendTableViewCell.swift
//  MovieProject
//
//  Created by 여성은 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class TrendTableViewCell: UITableViewCell {

    let dateLabel = UILabel()
    let genreLabel = UILabel()
    
    let infoView = UIView()
    
    let backdropImageView = UIImageView()
    
    let voteAverageView = UIView()
    let voteTextLabel = UILabel()
    let voteAverageLabel = UILabel()
    
    let titleLabel = UILabel()
    let castingLabel = UILabel()
    let devideView = UIView()
    let readmoreLabel = UILabel()
    let readmoreIcon = UIImageView()
    
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
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(backdropImageView)
        infoView.addSubview(voteAverageView)
        voteAverageView.addSubview(voteTextLabel)
        voteAverageView.addSubview(voteAverageLabel)
        infoView.addSubview(titleLabel)
        infoView.addSubview(castingLabel)
        infoView.addSubview(devideView)
        infoView.addSubview(readmoreLabel)
        infoView.addSubview(readmoreIcon)
        
    }
    func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(28)
        }
        infoView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(infoView.snp.width)
        }
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(infoView.safeAreaLayoutGuide)
            make.height.equalTo(infoView).multipliedBy(0.6)
        }
        voteAverageView.snp.makeConstraints { make in
            make.leading.equalTo(backdropImageView.snp.leading).offset(16)
            make.bottom.equalTo(backdropImageView.snp.bottom).offset(-16)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        voteTextLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(voteAverageView.safeAreaLayoutGuide)
            make.width.equalTo(28)
        }
        voteAverageLabel.snp.makeConstraints { make in
            make.leading.equalTo(voteTextLabel.snp.trailing)
            make.trailing.verticalEdges.equalTo(voteAverageView.safeAreaLayoutGuide)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(8)
            make.leading.equalTo(infoView.snp.leading).offset(16)
            make.height.equalTo(28)
        }
        castingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(infoView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        devideView.snp.makeConstraints { make in
            make.top.equalTo(castingLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(infoView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(1)
        }
        readmoreLabel.snp.makeConstraints { make in
            make.top.equalTo(devideView.snp.bottom).offset(16)
            make.leading.equalTo(infoView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(20)
        }
        readmoreIcon.snp.makeConstraints { make in
            make.top.equalTo(devideView.snp.bottom).offset(16)
            make.trailing.equalTo(infoView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
            
        }
    }
    func configureUI() {
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        
        genreLabel.font = .systemFont(ofSize: 14, weight: .heavy)
        
        infoView.clipsToBounds = true
        infoView.layer.cornerRadius = 10
        infoView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor.lightGray.cgColor
        
        voteTextLabel.text = "평점"
        voteTextLabel.textColor = .white
        voteTextLabel.font = .systemFont(ofSize: 13)
        voteTextLabel.textAlignment = .center
        voteTextLabel.backgroundColor = .purple
        voteAverageLabel.backgroundColor = .white
        voteAverageLabel.textAlignment = .center
        voteAverageLabel.font = .systemFont(ofSize: 13)
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        devideView.backgroundColor = .black
        
        readmoreLabel.text = "자세히 보기"
        readmoreLabel.font = .systemFont(ofSize: 12)
        readmoreLabel.textColor = .darkGray
        readmoreIcon.image = UIImage(systemName: "chevron.right")
        readmoreIcon.tintColor = .black
    }
    func configureCell(data: TrendResult) {
        dateLabel.text = data.release_date_string
        genreLabel.text = setGenreString(data: data.genre_ids)
        
        let url = URL(string: "https://image.tmdb.org/t/p/original\(data.backdrop_path)")
        backdropImageView.kf.setImage(with: url)
        
        voteAverageLabel.text = data.voteAverageFormat
        titleLabel.text = data.title
        
        
    }
    func setGenreString(data: [Int]) -> String {
        var result = ""
        for item in data {
            guard let genre = TrendViewController.genreList[item] else {return ""}
            result += "#\(genre) "
        }
        return result
    }
    
}
