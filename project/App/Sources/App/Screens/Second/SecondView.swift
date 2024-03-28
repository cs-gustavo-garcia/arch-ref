//
//  SecondView.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

final class SecondView: UIView {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SecondView: ViewConfiguration {
    
    func buildViewHierarchy() {}
    
    func setConstraints() {}
    
    func addAdditionalConfiguration() {
        backgroundColor = .brown
    }
    
}
