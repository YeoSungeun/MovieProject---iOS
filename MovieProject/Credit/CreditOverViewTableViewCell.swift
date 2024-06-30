//
//  CreditOverViewTableViewCell.swift
//  MovieProject
//
//  Created by 여성은 on 6/30/24.
//

import UIKit

class CreditOverViewTableViewCell: UITableViewCell {
    
    let overViewLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    let moreButton = {
        let button = UIButton()
        return button
    }

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
        contentView.addSubview(overViewLabel)
    }
    func configureLayout() {
        overViewLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
    }
    func configureUI() {
    }
    func configureCell(data: String) {
        overViewLabel.text = data
    }

}
