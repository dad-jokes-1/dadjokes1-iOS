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
    
    let apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let jokeQuestion = jokeTitleTextView.text,
            let jokeAnswer = jokePunchlineTextView.text else { return }
        
        apiController.post(joke: Joke(question: jokeQuestion, answer: jokeAnswer, username: ""))
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
