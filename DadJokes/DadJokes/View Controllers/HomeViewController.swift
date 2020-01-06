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
    
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func setupViews() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(signInButton)
        
        let smileAnimation = Animation.named("laugh")
        animationView.animation = smileAnimation
        animationView.loopMode = .loop
        animationView.play()
    }

}
