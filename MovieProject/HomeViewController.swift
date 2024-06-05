//
//  HomeViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/4/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let mainView = UIView()
    let mainPosterImageView = UIImageView()
    let playButton = UIButton()
    let likeButton = UIButton()
    
    let subView = UIView()
    let risingContentLabel = UILabel()
    
    let subFirstView = UIView()
    let subSecondView = UIView()
    let subThirdView = UIView()
    
    let subFirstPosterImageView = UIImageView()
    let subSecondPosterImgaeView = UIImageView()
    let subThirdPosterImageView = UIImageView()
    
    let firstTop10ImageView = UIImageView()
    let secondTop10ImageView = UIImageView()
    let thirdTop10ImageView = UIImageView()
    
    var movies = ["극한직업", "노량", "도둑들", "베테랑","1", "2", "3", "4", "5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    
    func configureNavigationBar() {
        navigationItem.title = "고래밥님"
    }
    
    func configureHierarchy() {
        view.addSubview(mainView)
        mainView.addSubview(mainPosterImageView)
        mainView.addSubview(playButton)
        mainView.addSubview(likeButton)
        
        view.addSubview(subView)
        subView.addSubview(risingContentLabel)
        subView.addSubview(subFirstView)
        subView.addSubview(subSecondView)
        subView.addSubview(subThirdView)
        
        subFirstView.addSubview(subFirstPosterImageView)
        subFirstView.addSubview(firstTop10ImageView)
        
        subSecondView.addSubview(subSecondPosterImgaeView)
        subSecondView.addSubview(secondTop10ImageView)
        
        subThirdView.addSubview(subThirdPosterImageView)
        subThirdView.addSubview(thirdTop10ImageView)
        
    }
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        mainView.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(480)
        }
        mainPosterImageView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(16)
            make.leading.equalTo(mainView.snp.leading).offset(24)
            make.trailing.equalTo(mainView.snp.trailing).offset(-24)
            make.bottom.equalTo(mainView.snp.bottom).offset(-16)
        }
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(mainPosterImageView.snp.leading).offset(40)
            make.bottom.equalTo(mainPosterImageView.snp.bottom).offset(-8)
            make.height.equalTo(28)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(mainPosterImageView).offset(-40)
            make.top.equalTo(playButton.snp.top)
            make.height.equalTo(28)
            
            
        }
        
    }
    func configureUI() {
        setDummyImage(view: mainPosterImageView)
        setDummyImage(view: subFirstPosterImageView)
        setDummyImage(view: subSecondPosterImgaeView)
        setDummyImage(view: subThirdPosterImageView)
        
        view.backgroundColor = .black
        mainView.backgroundColor = .darkGray.withAlphaComponent(0.3)
        subView.backgroundColor = .black
        
        playButton.setImage(UIImage.playNormal, for: .normal)
        playButton.setImage(UIImage.playHighlighted, for: .highlighted)
        
        likeButton.setTitleColor(.lightGray, for: .normal)
        likeButton.backgroundColor = .darkGray
        likeButton.layer.cornerRadius = 3
        likeButton.setImage(UIImage(systemName: "plus", variableValue: 0), for: .normal)
        likeButton.tintColor = .lightGray
        likeButton.setTitle("내가 찜한 리스트", for: .normal)
        
        risingContentLabel.text = "지금 뜨는 콘텐츠"
        risingContentLabel.textColor = .white
    }
    
    func setDummyImage(view: UIImageView) {
        view.image = UIImage(named: movies[0])
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
                             
    }


}
