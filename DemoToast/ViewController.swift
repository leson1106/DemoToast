//
//  ViewController.swift
//  DemoToast
//
//  Created by Sonny on 11/12/24.
//

import UIKit
import Toast

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        let size: CGFloat = 200
        let button = UIButton(frame: .init(origin: .init(x: view.center.x - size / 2, y: view.center.y - size / 2),
                                           size: .init(width: size, height: size)))
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(pushToSecondVC), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func pushToSecondVC() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

class SecondViewController: UIViewController {
    deinit {
        print("SecondViewController deinit")
    }
    
    private var toast: Toast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Second VC"
        
        let size: CGFloat = 200
        let button = UIButton(frame: .init(origin: .init(x: view.center.x - size / 2, y: view.center.y - size / 2),
                                           size: .init(width: size, height: size)))
        button.setTitle("Dismiss toast", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(dismissToast), for: .touchUpInside)
        view.addSubview(button)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        toast = showToast(message: "Hello Toast", defaultOnScreenTime: .infinity)
    }
    
    @objc private func dismissToast() {
        toast?.close()
    }
    
    @discardableResult
    private func showToast(message: String?, defaultOnScreenTime: Double, ignoreInteraction: Bool = false) -> Toast {
        let uiConfig = ToastViewConfiguration(darkBackgroundColor: .yellow,
                                              lightBackgroundColor: .yellow,
                                              titleNumberOfLines: 0,
                                              subtitleNumberOfLines: 0)
        
        var dismissable: [Toast.Dismissable] = [.time(time: defaultOnScreenTime)]
        dismissable.append(.swipe(direction: .natural))
        
        let toast = Toast.text(message ?? "Empty",
                               viewConfig: uiConfig,
                               config: ToastConfiguration(dismissBy: dismissable))
        toast.show()
        return toast
    }
}
