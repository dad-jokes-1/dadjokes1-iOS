//
//  PrivateJokeDetailViewController.swift
//  DadJokes
//
//  Created by John Kouris on 12/18/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PrivateJokeDetailViewController: UIViewController {
    
    @IBOutlet weak var jokeTitleTextView: UITextView!
    @IBOutlet weak var jokePunchlineTextView: UITextView!
    
    var apiController: APIController?
    var joke: Joke?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        jokeTitleTextView.text = joke?.question
        jokePunchlineTextView.text = joke?.answer
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let jokeQuestion = jokeTitleTextView.text,
            let jokeAnswer = jokePunchlineTextView.text else { return }
        
        if let joke = joke {
            apiController?.updateJoke(joke: joke, with: jokeQuestion, answer: jokeAnswer)
        } else {
            apiController?.createJoke(question: jokeQuestion, answer: jokeAnswer)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
