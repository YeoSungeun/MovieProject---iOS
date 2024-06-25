//
//  SearchMovieCollectionViewCell.swift
//  MovieProject
//
//  Created by 여성은 on 6/12/24.
//

import UIKit

class SearchMovieCollectionViewCell: UICollectionViewCell {
    static let id = "SearchMovieCollectionViewCell"
    
    var data: Result?
    let posterView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        configureHierarchy()
        configureLayout()
        configureUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureHierarchy() {
        contentView.addSubview(posterView)
    }
    func configureLayout() {
        posterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configureUI() {
        posterView.clipsToBounds = true
        posterView.contentMode = .scaleAspectFill
    }
    
    func configureCell(data: Result) {
      
        let url = URL(string: "https://image.tmdb.org/t/p/original\(data.poster_path ?? "/lfRkyNbs8cdLAY102Srujj4OWuv.jpg") ")
        posterView.kf.setImage(with: url)
    }
    
}
