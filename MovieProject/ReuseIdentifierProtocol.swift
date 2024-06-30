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

extension UICollectionViewCell: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self) // 파일명을 문자열로 주기 , self: class의 인스턴스
    }
}

extension UITableViewCell: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self) // 파일명을 문자열로 주기 , self: class의 인스턴스
    }
}
extension UITableViewHeaderFooterView: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self) 
    }
    
    
}

extension UIViewController: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
