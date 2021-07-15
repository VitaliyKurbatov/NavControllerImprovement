//
//  CustomNavigtionController.swift
//  TestNavController
//
//  Created by Vitaliy on 07.07.2021.
//

import UIKit

public class CustomNavigtionController: UINavigationController, UIGestureRecognizerDelegate {
    lazy var backButtonImage: UIImage = {
        return UIImage(named: "back_arrow_left_black")!.withRenderingMode(.alwaysTemplate).tinted(with: .purple)
    }()
    
    private var isPopAllowed: Bool {
        return viewControllers.last?.willTapBackButton() ?? true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationBar.barTintColor = .cyan  // не работает на увеличенном размере prefersLargeTitles = true
        navigationBar.titleTextAttributes = navigationBar.blackTitleTextAttribute
        
        interactivePopGestureRecognizer?.delegate = self  // без этого не работает свайп
    }
    
    // триггерим нажатие кнопки Назад
    public override func popViewController(animated: Bool) -> UIViewController? {
        if isPopAllowed {
            pop(animated: animated)
        }
        return nil
    }
    
    @discardableResult
    fileprivate func pop(animated: Bool) -> UIViewController? {
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
    
    // MARK: - public triggers for backButton
    // из-за objc диспетчеризация будет медленнее. Для данного функционала вроде не критично.
    /**
     Сообщает о нажатии backButton либо свайпе назад
     - Returns:
     true - если нужно выполнить обычный popViewController;
     false - если нужно запретить выполнение pop.
     */
    @objc func willTapBackButton() -> Bool {
        // method for override
        return true
    }
    
    /**
     Сообщает о выполнении метода popViewController
     */
    @objc func didTapBackButton() {
        // method for override
    }
    
    /**
     Принудительное выполнение метода popViewController
     */
    func popForce() {
        guard let customNavController = navigationController as? CustomNavigtionController else { return }
        // если ставить анимацию true, то метод не сработает при свайпе
        // при простом нажатии всё работает хорошо в любом случае
        customNavController.pop(animated: false)
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


public extension UINavigationBar {
    var blackTitleTextAttribute: [NSAttributedString.Key : Any] {
        return [.foregroundColor: UIColor.black]
    }
}
