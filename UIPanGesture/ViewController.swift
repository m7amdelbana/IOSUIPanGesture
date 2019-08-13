//
//  ViewController.swift
//  UIPanGesture
//
//  Created by Mohamed Elbana on 8/13/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgFolder: UIImageView!
    @IBOutlet weak var imgTrush: UIImageView!
    
    var folderViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPanGesture(view: imgFolder)
        folderViewOrigin = imgFolder.frame.origin
        
        view.bringSubviewToFront(imgFolder)
    }
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let folderView = sender.view!
     
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: folderView, sender: sender)
            return
        case .ended:
            if imgFolder.frame.intersects(imgTrush.frame) {
                self.deleteView(view: imgFolder)
            } else {
               self.returnViewToOrigin(view: imgFolder, origin: folderViewOrigin)
            }
            return
        default:
            return
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func deleteView(view: UIView) {
        UIView.animate(withDuration: 0.3) {
            view.alpha = 0.0
        }
    }
    
    func returnViewToOrigin(view: UIView, origin: CGPoint) {
        UIView.animate(withDuration: 0.3) {
            view.frame.origin = origin
        }
    }
}

