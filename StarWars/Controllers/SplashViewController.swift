//
//  SplashViewController.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 08.02.2021.
//

import UIKit

protocol SplashPresenterDescription: class {
    func present()
    func dismiss(completion: @escaping () -> Void)
}


class SplashViewController: UIViewController {
    
    static let logoImageBig: UIImage = UIImage(named: "dartBig")!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textImageView: UIImageView?

    var textImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textImageView?.image = textImage
     

        
    }
    

    

}

final class SplashPresenter: SplashPresenterDescription {
    
    private lazy var animator: SplashAnimatorDescription = SplashAnimator(foregroundSplashWindow: foregroundSplashWindow)
    
    private lazy var textImage: UIImage? = {
         let textsCount = 17
         
         let imageNumber = Int.random(in: 1...textsCount)
         let imageName = "i-splash-text-\(imageNumber)"
         
         return UIImage(named: imageName)
     }()
    
    private lazy var foregroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(with: textImage)
        let splashWindow = self.splashWindow(windowLevel: .normal + 1, rootViewController: splashViewController)
        
        return splashWindow
    }()

    private func splashWindow(windowLevel: UIWindow.Level, rootViewController: SplashViewController?) -> UIWindow {
        let splashWindow = UIWindow(frame: UIScreen.main.bounds)
        
        splashWindow.windowLevel = windowLevel
        splashWindow.rootViewController = rootViewController
        
        return splashWindow
    }
    
    private func splashViewController(with textImage: UIImage?) -> SplashViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
        
        let splashViewController = viewController as? SplashViewController
        splashViewController?.textImage = textImage

        return splashViewController
    }
    func present() {
        animator.animateAppearance()
    }
    func dismiss(completion: @escaping () -> Void) {
        
        animator.animateDisappearance(completion: completion)
    }
}


protocol SplashAnimatorDescription: class {
    func animateAppearance()
    func animateDisappearance(completion: @escaping () -> Void)
}

final class SplashAnimator: SplashAnimatorDescription {
    
    private unowned let foregroundSplashWindow: UIWindow
    private unowned let foregroundSplashViewController: SplashViewController

    init(foregroundSplashWindow: UIWindow) {
        self.foregroundSplashWindow = foregroundSplashWindow

        guard let foregroundSplashViewController = foregroundSplashWindow.rootViewController as? SplashViewController else {
            fatalError("Splash window doesn't have splash root view controller!")
        }
        
        self.foregroundSplashViewController = foregroundSplashViewController
    }
    
    func animateAppearance() {
        
               foregroundSplashWindow.isHidden = false
               
        foregroundSplashViewController.textImageView?.transform = CGAffineTransform(translationX: 0, y: 20)
               UIView.animate(withDuration: 2, animations: {
                   self.foregroundSplashViewController.logoImageView.transform = CGAffineTransform(scaleX: 88 / 72, y: 88 / 72)
                self.foregroundSplashViewController.textImageView?.transform = .identity
               })
               
        foregroundSplashViewController.textImageView?.alpha = 0
               UIView.animate(withDuration: 0.15, animations: {
                self.foregroundSplashViewController.textImageView?.alpha = 1
               })
           
    }
    
    func animateDisappearance(completion: @escaping () -> Void) {
        
        guard let window = UIApplication.shared.delegate?.window, let mainWindow = window else {
                  fatalError("Application doesn't have a window!")
              }

              foregroundSplashWindow.alpha = 0

              let mask = CALayer()
              mask.frame = foregroundSplashViewController.logoImageView.frame
              mask.contents = SplashViewController.logoImageBig.cgImage
              mainWindow.layer.mask = mask
          }
    
}
