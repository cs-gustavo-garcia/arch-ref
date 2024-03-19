//
//  FirstView.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

protocol FirstViewDelegate: AnyObject {
    func didTapActionButton()
}

final class FirstView: UIView {
    
    lazy var button: UIButton = {
        var button: UIButton = .init()
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(changeScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: FirstViewDelegate?
    var content: FirstViewContent? {
        didSet {
            updateView()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateView() {
        guard let content else {
            return
        }
        button.setTitle(content.buttonTitle, for: .normal)
    }
    
    @objc
    func changeScreen() {
        delegate?.didTapActionButton()
    }
    
}

extension FirstView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(button)
    }
    
    func setConstraints() {
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func addAdditionalConfiguration() {
        backgroundColor = .white
    }
}
