//
//  Button.swift
//  TestNavController
//
//  Created by Vitaliy on 12.07.2021.
//

import UIKit

class Button: UIButton {
    var action: (() -> Void)?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    convenience init(action: @escaping () -> Void) {
        self.init(frame: .zero)
        self.action = action
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setTitle("Жми", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .purple
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        action?()
    }
}
