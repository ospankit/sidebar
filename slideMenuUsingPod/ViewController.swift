//
//  ViewController.swift
//  slideMenuUsingPod
//
//  Created by Ankit on 24/02/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let transition = SlideInTransition()
    
    @IBOutlet weak var homeContainerView: UIView!
    
    @IBOutlet weak var navigationBackButton: UIButton!
    
    weak var navController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBackButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton, forEvent event: UIEvent) {
        let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        menuViewController.didTapMenuType = { MenuType in
            self.pushMenuTapToView(menuType: MenuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navController?.popViewController(animated: true)
        hideBackButton()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navController = segue.destination as? UINavigationController
    }
    
    func pushMenuTapToView(menuType:MenuType) {
        switch menuType {
        case .home:
            let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            checkViewAndPushPop(view: vc)
        case .camera:
            let vc = storyboard?.instantiateViewController(identifier: "CameraViewController") as! CameraViewController
            checkViewAndPushPop(view: vc)
        case .photo:
            let vc = storyboard?.instantiateViewController(identifier: "PhotoViewController") as! PhotoViewController
            checkViewAndPushPop(view: vc)
        }
        hideBackButton()
    }
    
    func checkViewAndPushPop(view:UIViewController) {
        if let stack = navController?.viewControllers {
            //var check = 0
            for vc in stack where vc.isKind(of: view.classForCoder) {
                navController?.popToViewController(vc, animated: false)
                return
            }
            navController?.pushViewController(view, animated: false)
        }
    }
    
    func hideBackButton() {
        if (navController?.viewControllers.count)! > 1{
            navigationBackButton.isHidden = false
        }else {
            navigationBackButton.isHidden = true
        }
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
