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
                self.dateSearchTextField.text = date
                self.tableView.reloadData()
            case .failure(let error):
                print("\(error)")
                self.list = [DailyBoxOfficeList(movieNm: "형식에 맞춰 날짜를 입력해주세요.", openDt: "", rank: "")]
                self.tableView.reloadData()
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
        dateSearchTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
        }
        dateSearchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(dateSearchTextField.snp.trailing).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
        textFieldUnderline.snp.makeConstraints { make in
            make.top.equalTo(dateSearchTextField.snp.bottom).offset(4)
            make.width.equalTo(dateSearchTextField.snp.width)
            make.leading.equalTo(dateSearchTextField.snp.leading)
            make.bottom.equalTo(dateSearchButton.snp.bottom)
            make.height.equalTo(4)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textFieldUnderline.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI() {
        view.backgroundColor = .black
  
        dateSearchTextField.attributedPlaceholder = NSAttributedString(string: "날짜를 입력하세요 ex)20240612", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.8)])
        dateSearchTextField.textColor = .white
        dateSearchTextField.font = .systemFont(ofSize: 15)
        dateSearchTextField.borderStyle = .none
        dateSearchTextField.backgroundColor = .clear
        dateSearchTextField.keyboardType = .numberPad
        
        dateSearchButton.setTitle("검색", for: .normal)
        dateSearchButton.setTitleColor( .black, for: .normal)
        dateSearchButton.backgroundColor = .white
        dateSearchButton.titleLabel?.font = .systemFont(ofSize: 16)
        dateSearchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
        textFieldUnderline.backgroundColor = .white
        
    }
    
    @objc func searchButtonClicked() {
        if let date = dateSearchTextField.text, !date.isEmpty {
            callResponse(date: date)
        }
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

