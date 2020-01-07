//
//  PublicJokesTableViewController.swift
//  DadJokes
//
//  Created by John Kouris on 12/18/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PublicJokesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // alert 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let alert = UIAlertController(title: "Sign up Alert!", message: "To view more or add dad jokes please sign up, under private tab.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source
// Creating an alert to sign up
//    func createAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.alert)
//
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PublicJokeCell", for: indexPath)
        
        return cell
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
