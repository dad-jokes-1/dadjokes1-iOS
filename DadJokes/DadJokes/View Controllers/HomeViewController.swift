//
//  HomeViewController.swift
//  DadJokes
//
//  Created by John Kouris on 12/19/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(signInButton)
        
        let smileAnimation = Animation.named("smile")
        animationView.animation = smileAnimation
        animationView.play()
    }

}
