//
//  ReuseIdentifierProtocol.swift
//  MovieProject
//
//  Created by 여성은 on 6/10/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self) // 파일명을 문자열로 주기 , self: class의 인스턴스
    }
}

extension UIViewController: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
