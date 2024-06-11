//
//  CreditViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/12/24.
//

import UIKit

class CreditViewController: UIViewController {
    
    var data: TrendResult? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = data?.title
    }
    


}
