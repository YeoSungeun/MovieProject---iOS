//
//  SignUpViewController.swift
//  MovieProject
//
//  Created by 여성은 on 6/4/24.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    let logoLabel = UILabel() 
    
    lazy var idTextField = setTextField(placeholder: "이메일 주소 또는 전화번호")
    lazy var passwordTextField = setTextField(placeholder: "비밀번호")
    lazy var nicknameTextField = setTextField(placeholder: "닉네임")
    lazy var locationTextField = setTextField(placeholder: "위치")
    lazy var recomendCodeTextField = setTextField(placeholder: "추천 코드 입력")
    
    let signupButton = UIButton()
    
    let extraInfoLabel = UILabel()
    let extraInfoSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        
    }
    func configureHierarchy() {
        let array = [logoLabel,
                     idTextField, passwordTextField, nicknameTextField, locationTextField, recomendCodeTextField,
                     signupButton, extraInfoLabel, extraInfoSwitch]
        for item in array {
            view.addSubview(item)
        }
    }
    func configureLayout() {
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(60)
        }
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(120)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.height.equalTo(28)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.height.equalTo(28)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.height.equalTo(28)
        }
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.height.equalTo(28)
        }
        recomendCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.height.equalTo(28)
        }
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(recomendCodeTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.height.equalTo(40)
        }
        extraInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(signupButton.snp.bottom).offset(16)
            make.leading.equalTo(signupButton.snp.leading)
        }
        extraInfoSwitch.snp.makeConstraints { make in
            make.top.equalTo(extraInfoLabel.snp.top)
            make.trailing.equalTo(signupButton.snp.trailing)
        }
        
        
    }
    func configureUI() {
        view.backgroundColor = .black
        
        logoLabel.text = "YEOFLIX"
        logoLabel.textAlignment = .center
        logoLabel.textColor = .red
        logoLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        signupButton.setTitle("회원가입", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        signupButton.backgroundColor = .white
        signupButton.layer.cornerRadius = 5
        
        extraInfoLabel.text = "추가 정보 입력"
        extraInfoLabel.textColor = .white
        extraInfoLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        extraInfoSwitch.onTintColor = .red
        extraInfoSwitch.thumbTintColor = .white
        extraInfoSwitch.subviews.first?.subviews.first?.backgroundColor = .lightGray
        extraInfoSwitch.isOn = true
    }

    func setTextField(placeholder: String) -> UITextField {
        let view = UITextField()
        view.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 13, weight: .semibold)
        view.backgroundColor = .darkGray
        view.borderStyle = .roundedRect
        
        return view
    }

}
