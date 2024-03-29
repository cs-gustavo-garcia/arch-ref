//
//  ViewConfiguration.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 19/03/24.
//

import Foundation

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setConstraints()
    func addAdditionalConfiguration()
}

extension ViewConfiguration {
    func setupView() {
        buildViewHierarchy()
        setConstraints()
        addAdditionalConfiguration()
    }
}
