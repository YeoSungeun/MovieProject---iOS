//
//  TrendViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/11/24.
//

import UIKit
import Alamofire



final class TrendViewController: UIViewController {
    
    private var tableView = UITableView()
    
    static var genreList: [Int:String] = [:]
    private var trendList: [TrendResult] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TrendManager.shared.apiRequest(api: .genre, model: Genres.self) { data in
            for item in data.genres {
                TrendViewController.genreList.updateValue(item.name, forKey: item.id)
            }
            print(TrendViewController.genreList)
        }
        TrendManager.shared.apiRequest(api: .trend(mediaType: .movie), model: Trend.self) { data in
            self.trendList = data.results
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
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    private func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        navigationItem.rightBarButtonItem = rightItem
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
        TrendManager.shared.apiRequest(api: .credit(id: trendList[indexPath.row].id), model: Cast.self) { cast in            var castingText = ""
            for i in cast.cast {
                castingText += i.name
            }
            cell.castingLabel.text = castingText
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 440
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreditViewController()
        vc.data = trendList[indexPath.row]

        self.navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        
    }
    
}
