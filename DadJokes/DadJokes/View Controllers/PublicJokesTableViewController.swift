//
//  PublicJokesTableViewController.swift
//  DadJokes
//
//  Created by John Kouris on 12/18/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PublicJokesTableViewController: UITableViewController {
    
    let apiController = APIController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PublicJokeCell", for: indexPath)
        
        cell.textLabel?.text = apiController.searchResults[indexPath.row].question
        cell.selectionStyle = .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentDJAlertOnMainThread(title: "Alert", message: DJError.publicCantViewPunchline.rawValue, buttonTitle: "Ok")
    }

}
