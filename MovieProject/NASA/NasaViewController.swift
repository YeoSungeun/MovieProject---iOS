//
//  NasaViewController.swift
//  MovieProject
//
//  Created by 여성은 on 7/1/24.
//

import UIKit

final class NasaViewcController: UIViewController {
    private enum Nasa: String, CaseIterable {
        
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
        
        static var photo: URL {
            return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
    
    let nasaImageView = UIImageView()
    let progressLabel = UILabel()
    let requestButton = UIButton()
    
    var session = URLSession()
    
    var total: Double = 0
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(String(format: "%.2f",result * 100)) / 100"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.invalidateAndCancel() // 화면이 사라지면 네트워크 통신 중단!
    }
    
    func configureHierarchy() {
        view.addSubview(requestButton)
        view.addSubview(progressLabel)
        view.addSubview(nasaImageView)
    }
    func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        nasaImageView.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    func configureView() {
        view.backgroundColor = .white
        requestButton.backgroundColor = .blue.withAlphaComponent(0.5)
        requestButton.setTitle("Nasa Image 불러오기", for: .normal)
        requestButton.setTitleColor(.white, for: .normal)
        requestButton.layer.cornerRadius = 25
        progressLabel.textAlignment = .center
        progressLabel.backgroundColor = .lightGray
        progressLabel.clipsToBounds = true
        progressLabel.layer.cornerRadius = 20
        nasaImageView.clipsToBounds = true
        nasaImageView.contentMode = .scaleAspectFill
        
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    func callRequest() {
        let request = URLRequest(url: Nasa.photo)
        session = URLSession(configuration: .default,
                             delegate: self,
                             delegateQueue: .main)
        session.dataTask(with: request).resume()
    }
    @objc func requestButtonClicked() {
        print(#function)
        buffer = Data()
        callRequest()
        requestButton.isEnabled = false
    }
}

extension NasaViewcController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, 
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print(#function, response)
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            
            // 총 데이터의 양 얻기
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length"), let contentLength = Double(contentLength) else { return .allow }
            total = contentLength
            
            return .allow
        } else {
            print("cancel")
            return .cancel
        }
    }
    func urlSession(_ session: URLSession, 
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        print(#function, data)
        
        buffer?.append(data)
        
    }
    func urlSession(_ session: URLSession, 
                    task: URLSessionTask,
                    didCompleteWithError error: (any Error)?) {
        if let error = error {
            progressLabel.text = "사진을 불러오는데 실패했습니다."
            nasaImageView.image = UIImage(systemName: "star")
        } else {
            print("성공")
            guard let buffer = buffer else {
                print("Buffer nil")
                progressLabel.text = "사진을 불러오는데 실패했습니다."
                nasaImageView.image = UIImage(systemName: "star")
                requestButton.isEnabled = true
                return
            }
            let image = UIImage(data: buffer)
            nasaImageView.image = image
        }
        requestButton.isEnabled = true
    }
    
}
