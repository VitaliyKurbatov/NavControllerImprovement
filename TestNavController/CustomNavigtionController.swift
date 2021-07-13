//
//  CustomNavigtionController.swift
//  TestNavController
//
//  Created by Vitaliy on 07.07.2021.
//

import UIKit

public class CustomNavigtionController: UINavigationController, UIGestureRecognizerDelegate {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.backIndicatorImage = UINavigationController.backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = UINavigationController.backButtonImage
        navigationBar.barTintColor = .cyan  // не работает на увеличенном размере prefersLargeTitles = true
        navigationBar.titleTextAttributes = navigationBar.blackTitleTextAttribute
        
        interactivePopGestureRecognizer?.delegate = self  // без этого не работает свайп
    }
    
    // триггерим нажатие кнопки Назад
    public override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        vc?.didTapBackButton()
        return vc
    }
    
    // активируем свайп назад
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


public extension UIViewController {
    // Используя нативную backButton удаляем её title
    func removeBackButtonTitle() {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    // public trigger
    // из-за objc диспетчеризация будет медленнее. Для данного функционала вроде не критично
    @objc func didTapBackButton() {
        // method for override
    }
    
    func addTwoLinesTitle(first: String, second: String) {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let firstLabel = UILabel()
        firstLabel.font = UIFont.boldSystemFont(ofSize: 23)
        firstLabel.textAlignment = .center
        
        let secondLabel = UILabel()
        secondLabel.font = UIFont.boldSystemFont(ofSize: 23)
        secondLabel.textAlignment = .center
        
        [firstLabel, secondLabel].forEach { stackView.addArrangedSubview($0) }
        
        firstLabel.text = first
        secondLabel.text = second
        
        navigationItem.titleView = stackView
    }
}

public extension UINavigationController {
    // В экстеншине нельзя хранить lazy поэтому
    // использован static let, так как он создается один раз как и lazy.
    static let backButtonImage = UIImage(named: "back_arrow_left_black")!.withRenderingMode(.alwaysTemplate).tinted(with: .purple)
}

public extension UINavigationBar {
    var blackTitleTextAttribute: [NSAttributedString.Key : Any] {
        return [.foregroundColor: UIColor.black]
    }
}
