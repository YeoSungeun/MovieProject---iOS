//
//  CreditDetailView.swift
//  MovieProject
//
//  Created by 여성은 on 7/1/24.
//

import UIKit
import SnapKit

final class CreditDetailView: UIView {

    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let posterImageView = UIImageView()
    
    init(data: TrendResult) {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
        configureUI(data: data)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(posterImageView)
    }
    private func configureLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self).inset(20)
            make.height.equalTo(50)
        }
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self).inset(20)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
        }
    }
    private func configureUI(data: TrendResult) {
        backgroundImageView.setImageView(path: data.backdrop_path)
        titleLabel.text = data.title
        posterImageView.setImageView(path: data.poster_path)
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
    }
    

}
