//
//  FirstView.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

public final class FirstView: UIView {
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        backgroundColor = .blue
    }
    
}
