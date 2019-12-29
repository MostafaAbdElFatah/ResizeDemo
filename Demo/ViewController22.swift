//
//  ViewController.swift
//  Demo
//
//  Created by Mostafa on 12/26/19.
//  Copyright © 2019 Mostafa. All rights reserved.
//

import UIKit


enum SlideOutState {
   case Collapsed
   case Expanded
}

class ViewController: UIViewController {


    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var greenViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.redButton.center = CGPoint(x: self.blueView.frame.origin.x + self.blueView.frame.size.width , y: self.blueView.frame.origin.y + self.blueView.frame.size.height)
    }

    @IBAction func bluePanViewMoved(_ sender: UIPanGestureRecognizer) {
        let translation:CGPoint = sender.translation(in: self.blueView)
        self.blueView.center = CGPoint(x: self.blueView.center.x + translation.x, y: self.blueView.center.y + translation.y)
        self.redButton.center = CGPoint(x: self.blueView.frame.origin.x + self.blueView.frame.size.width, y: self.blueView.frame.origin.y + self.blueView.frame.size.height)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func redBtnPaned(_ sender: UIPanGestureRecognizer) {
        let translation:CGPoint = sender.location(in: self.view)
        sender.view?.center = translation
        self.blueView.frame = CGRect(x: self.blueView.frame.origin.x, y: self.blueView.frame.origin.y
            , width: translation.x - self.blueView.frame.origin.x
            , height: translation.y - self.blueView.frame.origin.y)
        self.redButton.center = CGPoint(x: translation.x, y: translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        sender.view?.center = translation
    }
    
    
    @IBAction func greenViewPanned(_ sender: UIPanGestureRecognizer) {

        let velocity = sender.velocity(in: self.view)
        let translation = sender.translation(in: self.view)
        
        switch(sender.state) {
        case .changed:
            let constant = greenView.frame.origin.y + translation.y
            if constant < self.view.frame.height - 200 || constant > self.view.frame.height - 50 {
                return
            }
            if self.greenViewConstraint.constant - abs(translation.y) > 150 || self.greenViewConstraint.constant + abs(translation.y) < 0 {
                return
            }
            UIView.animate(withDuration: 0.5) {
                if velocity.y > 0{
                    self.greenViewConstraint.constant = self.greenViewConstraint.constant + abs(translation.y)
                    self.view.layoutIfNeeded()
                }else{
                    self.greenViewConstraint.constant = self.greenViewConstraint.constant - abs(translation.y)
                    self.view.layoutIfNeeded()
                }
                
                //self.greenView.center.y = self.greenView.center.y + translation.y
                sender.setTranslation(CGPoint.zero, in: self.view)
            }
        case .ended: break
            
        default:
            break
        }
    }
    
   
    
    
}

