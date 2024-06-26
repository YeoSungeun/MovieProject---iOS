//
//  TrendViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/11/24.
//

import UIKit
import Alamofire



class TrendViewController: UIViewController {
    
    var tableView = UITableView()
    
    static var genreList: [Int:String] = [:]
    var trendList: [TrendResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        callRequestGenre()
        TrendManager.shared.trendRequest(api: .trend(mediaType: .movie)) { data in
            self.trendList = data
            self.tableView.reloadData()
        }
        configureHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
        

    }
    @objc func searchButtonClicked(){
        navigationController?.pushViewController(SearchMovieViewController(), animated: false)
    }
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func callRequestGenre() {
        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(APIKey.tmdbKey)"
        
        AF.request(url).responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let value):
                for item in value.genres {
                    TrendViewController.genreList.updateValue(item.name, forKey: item.id)
                }
                print(TrendViewController.genreList)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        
        cell.configureCell(data: trendList[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 440
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreditViewController()
        vc.data = trendList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
