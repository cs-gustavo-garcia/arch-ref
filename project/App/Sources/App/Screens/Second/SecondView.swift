//
//  SecondView.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

protocol SecondViewDelegate: AnyObject {
    func didTapChangeScreenButton()
}

final class SecondView: UIView {
    
    lazy var button: UIButton = {
        let button: UIButton = .init(type: .system)
        button.addTarget(self, action: #selector(changeScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: SecondViewDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        backgroundColor = .blue
    }
    
    @objc
    func changeScreen() {}
    
}

extension SecondView: ViewConfiguration {
    
    func buildViewHierarchy() {
        [button].forEach(addSubview(_:))
    }
    
    func setConstraints() {
        [button.centerXAnchor.constraint(equalTo: centerXAnchor),
         button.centerYAnchor.constraint(equalTo: centerYAnchor),
         button.widthAnchor.constraint(equalToConstant: 100),
         button.heightAnchor.constraint(equalToConstant: 50)].forEach { constraint in
            constraint.isActive = true
        }
    }
    
    func addAdditionalConfiguration() {
        backgroundColor = .brown
    }
    
}
