//
//  CreditTableViewHeaderView.swift
//  MovieProject
//
//  Created by 여성은 on 7/1/24.
//

import UIKit
import SnapKit

class CreditTableViewHeaderView: UITableViewHeaderFooterView {
    
    let sectionTitleLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .boldSystemFont(ofSize: 13)
        return view
        
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .red
        configureHierarchy()
        configureLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureHierarchy() {
        addSubview(sectionTitleLabel)
    }
    func configureLayout() {
        sectionTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.bottom.equalTo(self)
            make.height.equalTo(40)
        }
    }
    
}
