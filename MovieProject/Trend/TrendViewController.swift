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
    
    lazy var genreList: [Int:String] = [:]
    var trendList: [TrendResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        callRequestGenre()
        callRequest()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    func configureLayout() {
        
    }
    func configureUI() {
        
    }
    
    func callRequestGenre() {
        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(APIKey.tmdbKey)"
        
        AF.request(url).responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let value):
                for item in value.genres {
                    self.genreList.updateValue(item.name, forKey: item.id)
                }
                print(self.genreList)
            case .failure(let error):
                print(error)
            }
        }
    }

    func callRequest() {
        let mediaType = MediaType.movie.rawValue
        let time_window = time_window.day.rawValue
        let url = "\(APIURL.trendURL)/\(mediaType)/\(time_window)?api_key=\(APIKey.tmdbKey)"
        
        AF.request(url, method: .get).responseDecodable(of: Trend.self) { response in
            switch response.result {
            case .success(let value):
                self.trendList = value.results
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
        <#code#>
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
}
