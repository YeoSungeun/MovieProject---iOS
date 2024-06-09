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
    
    
    
    var list: [DailyBoxOfficeList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        callResponse(date: "20240112")
    }
    
    func callResponse(date: String) {
        let url = "\(APIURL.boxofficURL)key=\(APIKey.movieKey)&targetDt=\(date)"

        AF.request(url).responseDecodable(of: Welcome.self) { response in
            switch response.result {
            case .success(let value):
                self.list = value.boxOfficeResult.dailyBoxOfficeList
                print("\(self.list)")
            case .failure(let error):
                print("\(error)")
            }
        }
    }

}

/*
 {"boxOfficeResult":{"boxofficeType":"일별 박스오피스","showRange":"20240112~20240112","dailyBoxOfficeList":[{"rnum":"1","rank":"1","rankInten":"0","rankOldAndNew":"OLD","movieCd":"20235253","movieNm":"외계+인 2부","openDt":"2024-01-10","salesAmt":"816243397","salesShare":"36.8","salesInten":"212678048","salesChange":"35.2","salesAcc":"2405858725","audiCnt":"84840","audiInten":"19847","audiChange":"30.5","audiAcc":"253367","scrnCnt":"1335","showCnt":"5325"},{"rnum":"2","rank":"2","rankInten":"0","rankOldAndNew":"OLD","movieCd":"20235834","movieNm":"위시","openDt":"2024-01-03","salesAmt":"384017259","salesShare":"17.3","salesInten":"77819949","salesChange":"25.4","salesAcc":"7849249593","audiCnt":"40569","audiInten":"6984","audiChange":"20.8","audiAcc":"821254","scrnCnt":"933","showCnt":"2762"},{"rnum":"3","rank":"3","rankInten":"0","rankOldAndNew":"OLD","movieCd":"20212866","movieNm":"서울의 봄","openDt":"2023-11-22","salesAmt":"273548682","salesShare":"12.3","salesInten":"57623846","salesChange":"26.7","salesAcc":"123499137789","audiCnt":"27486","audiInten":"4846","audiChange":"21.4","audiAcc":"12675078","scrnCnt":"882","showCnt":"2270"},{"rnum":"4","rank":"4","rankInten":"0","rankOldAndNew":"OLD","movieCd":"20203702","movieNm":"노량: 죽음의 바다","openDt":"2023-12-20","salesAmt":"242798727","salesShare":"11.0","salesInten":"52890248","salesChange":"27.9","salesAcc":"42329674354","audiCnt":"25169","audiInten":"4760","audiChange":"23.3","audiAcc":"4292420","scrnCnt":"962","showCnt":"2235"},{"rnum":"5","rank":"5","rankInten":"0","rankOldAndNew":"OLD","movieCd":"20235583","movieNm":"인투 더 월드","openDt":"2024-01-10","salesAmt":"133682447","salesShare":"6.0","salesInten":"15520495","salesChange":"13.1","salesAcc":"492787869","audiCnt":"14687","audiInten":"1331","audiChange":"10","audiAcc":"54695","scrnCnt":"795","showCnt":"1787"},{"rnum":"6","rank":"6","rankInten":"0","rankOldAndNew":"OLD","movieCd":"20236146","movieNm":"신차원! 짱구는 못말려 더 무비 초능력 대결전 ~날아라 수제김밥~","openDt":"2023-12-22","salesAmt":"63635158","salesShare":"2.9","salesInten":"8301882","salesChange":"15","salesAcc":"7608090459","audiCnt":"6410","audiInten":"653","audiChange":"11.3","audiAcc":"787279","scrnCnt":"416","showCnt":"568"},{"rnum":"7","rank":"7","rankInten":"0","rankOldAndNew":"OLD","movieCd":"20235353","movieNm":"길위에 김대중","openDt":"2024-01-10","salesAmt":"54027477","salesShare":"2.4","salesInten":"2741187","salesChange":"5.3","salesAcc":"360718135","audiCnt":"5432","audiInten":"-21","audiChange":"-0.4","audiAcc":"38244","scrnCnt":"397","showCnt":"555"},{"rnum":"8","rank":"8","rankInten":"1","rankOldAndNew":"OLD","movieCd":"20234114","movieNm":"괴물","openDt":"2023-11-29","salesAmt":"37411813","salesShare":"1.7","salesInten":"8592262","salesChange":"29.8","salesAcc":"4384763901","audiCnt":"3706","audiInten":"640","audiChange":"20.9","audiAcc":"446512","scrnCnt":"175","showCnt":"242"},{"rnum":"9","rank":"9","rankInten":"-1","rankOldAndNew":"OLD","movieCd":"20228555","movieNm":"더 퍼스트 슬램덩크","openDt":"2023-01-04","salesAmt":"32910804","salesShare":"1.5","salesInten":"697170","salesChange":"2.2","salesAcc":"50579024231","audiCnt":"3073","audiInten":"-123","audiChange":"-3.8","audiAcc":"4837645","scrnCnt":"206","showCnt":"256"},{"rnum":"10","rank":"10","rankInten":"1","rankOldAndNew":"OLD","movieCd":"20236557","movieNm":"스즈메의 문단속: 다녀왔어","openDt":"2024-01-10","salesAmt":"28057942","salesShare":"1.3","salesInten":"-341022","salesChange":"-1.2","salesAcc":"128901307","audiCnt":"2717","audiInten":"-190","audiChange":"-6.5","audiAcc":"12960","scrnCnt":"176","showCnt":"196"}]}
 }

 */
