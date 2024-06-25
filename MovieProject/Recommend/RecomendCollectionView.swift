//
//  RecomendCollectionView.swift
//  MovieProject
//
//  Created by 여성은 on 6/25/24.
//

import UIKit
import SnapKit

class RecomendCollectionView: UIView {

    var list: [MovieResult] = []
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    init(list: [MovieResult]) {
        super.init(frame: .zero)
        self.list = list
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width/4, height: (width/4)*(4.3))
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return layout
    }
}
