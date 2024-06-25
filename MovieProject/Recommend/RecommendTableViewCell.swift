//
//  RecommendTableViewCell.swift
//  MovieProject
//
//  Created by 여성은 on 6/25/24.
//

import UIKit
import SnapKit

class RecommendTableViewCell: UITableViewCell {
    let titleLabel = {
        let view = UILabel()
        view.text = "추천 영화"
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 160)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView)
            make.leading.equalTo(contentView).inset(10)
            make.height.equalTo(40)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    func configureView() {
        contentView.backgroundColor = .black
        collectionView.backgroundColor = .black
        
    }
}

