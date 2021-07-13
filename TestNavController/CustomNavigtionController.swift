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
    // Вариант 1
    // Устанавливаем leftButton в качестве backButton
    // Нюанс: не работает родное контекстное меню кнопки Назад
    func setupBackButton() {
        guard let navigationController = navigationController,
              navigationController.viewControllers.count > 1 else {
            return }
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UINavigationController.backButtonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonPressed))
        backButton.accessibilityLabel = "Назад"
        navigationItem.leftBarButtonItem = backButton
    }
    
    /// private native 'pop' functionality
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // public trigger
    // из-за objc диспетчеризация будет медленнее. Для данного функционала вроде не критично
    @objc func didTapBackButton() {
        // method for override
    }
    
    
    /*
     // Вариант 2
     // Используем нативную backButton
     
    func removeBackButtonTitle() {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
     
     override func willMove(toParent parent: UIViewController?) {
         super.willMove(toParent: parent)
         if parent == nil {
             print("Pressed backButton or swiped back")
         }
     }
      */
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