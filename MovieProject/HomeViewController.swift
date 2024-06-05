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
    
    let posterStackView = UIStackView()
    
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
        subView.addSubview(posterStackView)
        
        
        posterStackView.addArrangedSubview(subFirstView)
        posterStackView.addArrangedSubview(subSecondView)
        posterStackView.addArrangedSubview(subThirdView)
        
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
            make.height.equalTo(440)
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
        
        subView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeArea)
        }
        risingContentLabel.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).offset(8)
            make.leading.equalTo(subView.snp.leading).offset(16)
            make.height.equalTo(28)
        }
        posterStackView.snp.makeConstraints { make in
            make.top.equalTo(risingContentLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeArea).inset(16)
            make.bottom.equalTo(safeArea).offset(-8)
        }
        subFirstPosterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subSecondPosterImgaeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subThirdPosterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        firstTop10ImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(30)
        }
        secondTop10ImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(30)
        }
        thirdTop10ImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(30)
        }
    }
    func configureUI() {
        setDummyImage(view: mainPosterImageView, index: 1)
        setDummyImage(view: subFirstPosterImageView, index: 2)
        setDummyImage(view: subSecondPosterImgaeView, index: 3)
        setDummyImage(view: subThirdPosterImageView, index: 4)
        setTop10Image(view: firstTop10ImageView)
        setTop10Image(view: secondTop10ImageView)
        setTop10Image(view: thirdTop10ImageView)
        
        view.backgroundColor = .black
        mainView.backgroundColor = .darkGray.withAlphaComponent(0.3)
        subView.backgroundColor = .black
        
        playButton.setImage(UIImage.playNormal, for: .normal)
        playButton.setImage(UIImage.playHighlighted, for: .highlighted)
        playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        
        likeButton.setTitleColor(.lightGray, for: .normal)
        likeButton.backgroundColor = .darkGray
        likeButton.layer.cornerRadius = 3
        likeButton.setImage(UIImage(systemName: "plus", variableValue: 0), for: .normal)
        likeButton.tintColor = .lightGray
        likeButton.setTitle("내가 찜한 리스트", for: .normal)
        
        risingContentLabel.text = "지금 뜨는 콘텐츠"
        risingContentLabel.textColor = .white
        
        configureStackView(stackView: posterStackView)
        
    }
    
    func setDummyImage(view: UIImageView, index: Int) {
        view.image = UIImage(named: movies[index])
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
                             
    }
    func setTop10Image(view: UIImageView){
        view.image = UIImage.top10Badge
        view.contentMode = .scaleToFill
        view.isHidden = (Int.random(in: 0...1) != 0) ? true : false
    }
    func configureStackView(stackView: UIStackView){
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
    }
    @objc func playButtonClicked() {
        print(#function)
        movies.shuffle()
        setDummyImage(view: mainPosterImageView, index: 1)
        setDummyImage(view: subFirstPosterImageView, index: 2)
        setDummyImage(view: subSecondPosterImgaeView, index: 3)
        setDummyImage(view: subThirdPosterImageView, index: 4)
        
        setTop10Image(view: firstTop10ImageView)
        setTop10Image(view: secondTop10ImageView)
        setTop10Image(view: thirdTop10ImageView)
    }


}
