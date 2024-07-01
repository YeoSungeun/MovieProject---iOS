//
//  CreditViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/12/24.
//

import UIKit

enum CreditSection: String {
    case overView  = "OverView"
    case cast = "Cast"
}
struct CreditReuslt {
    var section: CreditSection
    var overView: String?
    var cast: [CastResult]?
}
final class CreditViewController: UIViewController {
    
    private var data: TrendResult? = nil
    
    private lazy var detailView = CreditDetailView(data: self.data ?? TrendResult(backdrop_path: "", id: 0, overview: "", poster_path: "", title: "", genre_ids: [0], release_date: "", vote_average: 0))
    
    private lazy var overView: String = data?.overview ?? ""
    private var castList: [CastResult] = []
    private lazy var creditList: [CreditReuslt] = [
        CreditReuslt(section: .overView, overView: self.overView),
        CreditReuslt(section: .cast, cast: self.castList)
    ] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(CreditTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: CreditTableViewHeaderView.identifier)
        view.register(CreditCastTableViewCell.self, forCellReuseIdentifier: CreditCastTableViewCell.identifier)
        view.register(CreditOverViewTableViewCell.self, forCellReuseIdentifier: "CreditOverViewTableViewCell")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TrendManager.shared.apiRequest(api: .credit(id: data?.id ?? 0), model: Cast.self) { cast in
            self.castList = Array(cast.cast.prefix(10))
            self.creditList[1].cast = Array(cast.cast.prefix(10))
            print(self.castList, self.creditList)
        }
        configureHierarchy()
        configureLayout()
        configureView()
    }
    private func configureHierarchy() {
        view.addSubview(detailView)
        view.addSubview(tableView)
        
    }
    private func configureLayout() {
        detailView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureView() {
        view.backgroundColor = .white
        self.title = "출연/제작"
    }

}
extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return creditList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            guard let data = creditList[section].cast else { return 1 }
            return data.count
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CreditTableViewHeaderView.identifier) as? CreditTableViewHeaderView else { return nil}
        view.sectionTitleLabel.text = creditList[section].section.rawValue
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch creditList[indexPath.section].section {
        case .overView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditOverViewTableViewCell.identifier, for: indexPath) as? CreditOverViewTableViewCell, let data = self.data else { return UITableViewCell() }
            cell.configureCell(data: data.overview)
            return cell
        case .cast :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditCastTableViewCell.identifier, for: indexPath) as? CreditCastTableViewCell else { return UITableViewCell() }
            cell.configureCell(data: castList[indexPath.row])
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
