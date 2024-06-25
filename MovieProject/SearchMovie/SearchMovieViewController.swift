//
//  SearchMovieViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/12/24.
//

import UIKit
import Alamofire
import SnapKit

class SearchMovieViewController: UIViewController {
    
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var list: SearchMovie = SearchMovie(page: 0, total_pages: 0, total_results: 0, results: [])
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI() {
        navigationItem.title = "영화검색"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 10
        searchBar.barTintColor = .black.withAlphaComponent(0.2)
        searchBar.tintColor = .white.withAlphaComponent(0.8)
        searchBar.placeholder = "영화 제목을 검색해보세요."
        searchBar.searchTextField.textColor = .white
        
        collectionView.backgroundColor = .black
        
    }
    func configureView() {
        searchBar.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchMovieCollectionViewCell.self, forCellWithReuseIdentifier: SearchMovieCollectionViewCell.id)
        
    }
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/3, height: (width/3)*(4/3))
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func callRequest(query: String) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(APIKey.tmdbKey)&query=\(query)&page=\(page)"

        AF.request(url).responseDecodable(of: SearchMovie.self) { response in
            switch response.result {
            case .success(let value):
                print("page\(value.page), totalpage: \(value.total_pages), totalresult: \(value.total_results)")
                if self.page == 1 {
                    self.list = value
                } else {
                    self.list.results.append(contentsOf: value.results)
                }
                self.collectionView.reloadData()
                
                if self.page == 1 {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else { return }
        callRequest(query: text)
    }
}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCollectionViewCell.id, for: indexPath) as! SearchMovieCollectionViewCell
        cell.configureCell(data: list.results[indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = RecommendViewController()
        vc.id = list.results[indexPath.item].id
        vc.movieTitle = list.results[indexPath.item].title
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchMovieViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("prefetch:\(indexPaths) ")
        
        for item in indexPaths {
            if list.results.count - 2 == item.item && list.total_pages != self.page {
                print("count:\(list.results.count - 2)item:\(item.item)",#function)
                page += 1
                guard let text = searchBar.text else { return }
                callRequest(query: text)
            }
        }
    }
    
    
}
