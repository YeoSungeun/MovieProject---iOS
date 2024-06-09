//
//  BoxOfficeViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/9/24.
//

import UIKit
import Alamofire
import SnapKit

// MARK: - Welcome
struct Welcome: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let movieNm, openDt, rank: String
}


class BoxOfficeViewController: UIViewController {
    
    let dateSearchTextField = UITextField()
    let dateSearchButton = UIButton()
    let textFieldUnderline = UIView()
    
    let tableView = UITableView()
    
    var list: [DailyBoxOfficeList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        callResponse(date: Date.boxofficeDate())
        configureHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
    }
    
    func callResponse(date: String) {
        let url = "\(APIURL.boxofficURL)key=\(APIKey.movieKey)&targetDt=\(date)"

        AF.request(url).responseDecodable(of: Welcome.self) { response in
            switch response.result {
            case .success(let value):
                self.list = value.boxOfficeResult.dailyBoxOfficeList
                self.tableView.reloadData()
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func configureHierarchy() {
        view.addSubview(dateSearchTextField)
        view.addSubview(dateSearchButton)
        view.addSubview(textFieldUnderline)
        view.addSubview(tableView)
    }
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI() {
        view.backgroundColor = .black
    }

}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        
        tableView.backgroundColor = .black
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(data: list[indexPath.row])
        return cell
    }
    
    
}
