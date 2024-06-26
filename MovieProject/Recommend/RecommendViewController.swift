//
//  RecomendViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/25/24.
//

import UIKit
import SnapKit

class RecommendViewController: UIViewController {
    
    var id: Int = 0
    var movieTitle: String = ""
    var list: [[MovieResult]] = []
    var posterList: [[PosterResult]] = []
    let titleText = ["추천 영화", "비슷한 영화", "포스터"]

    let titleLabel = UILabel()
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        print("list", list)
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            RecommendManager.shared.recommendationsRequest(api: .recommendMovie(id: self.id)) { data, error in
                // success -> data o([MovieResult]?) , error nil
                // failure -> data nil, error o(String?)
                if let error = error {
                    print("error")
                    // alert을 띄워줄까?
                } else {
                    guard let data = data else { return }
                    var test: [MovieResult] = []
                    if data.count >= 10 {
                        for i in 0...9 {
                            test.append(data[i])
                        }
                    } else {
                        test = data
                    }
                    self.list.append(test)
                    print("list2",self.list)
                }
                group.leave()
            }
           
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            RecommendManager.shared.recommendationsRequest(api: .similarMovie(id: self.id)) { data, error in
                if let error = error {
                    print(error)
                } else {
                    guard let data = data else { return }
                    var test: [MovieResult] = []
                    if data.count >= 10 {
                        for i in 0...9 {
                            test.append(data[i])
                        }
                    } else {
                        test = data
                    }
                    self.list.append(test)
                    print("list3",self.list)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            RecommendManager.shared.posterRequest(
                api: .images(id: self.id)) { data in
                    var test: [PosterResult] = []
                    if data.count >= 10 {
                        for i in 0...9 {
                            test.append(data[i])
                        }
                    } else {
                        test = data
                    }
                    self.posterList.append(test)
                    print("list3",self.list)
                    group.leave()
                } errorHandler: { error in
                    print(error)
                    group.leave()
                }

        }
        
        group.notify(queue: .main) {
            print("그룹 다끝남~~!")
            print("list4",self.list)
            self.tableView.reloadData()
        }

        configureHierarchy()
        configureLayout()
        configureView()
    }
    func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    func configureView() {
        view.backgroundColor = .black
        tableView.rowHeight = 220
        tableView.backgroundColor = .black
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        titleLabel.text = movieTitle
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 24)
    }
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count  + posterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCell.identifier, for: indexPath) as! RecommendTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.titleLabel.text = titleText[indexPath.row]
        return cell
    }
    
}

extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2 {
            return posterList[0].count
        } else {
            return list[collectionView.tag].count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as! RecommendCollectionViewCell
        if collectionView.tag == 2 {
            guard let path = posterList[0][indexPath.item].file_path else {
                return cell }
            let url = URL(string: "https://image.tmdb.org/t/p/original\(path)")
            cell.posterImageView.kf.setImage(with: url)
        } else {
            guard let path = list[collectionView.tag][indexPath.item].poster_path else { return cell }
            let url = URL(string: "https://image.tmdb.org/t/p/original\(path)")
            cell.posterImageView.kf.setImage(with: url)
        }
        return cell
    }
    
    
}
