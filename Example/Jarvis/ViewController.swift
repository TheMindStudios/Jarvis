//
//  ViewController.swift
//  Jarvis
//
//  Created by Sergey Degtyar on 11/06/2017.
//  Copyright (c) 2017 Sergey Degtyar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    private let reuseIdentifier = "defaultCell"
    private let postsListAPIClient = PostsListAPIClient()
    private var dataSource: [Post] = []
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPosts()
    }
}

// MARK: - API

extension ViewController {
    
    private func getPosts(for page: Int = 1) {
        
        showLoader()
        
        postsListAPIClient.getPosts(for: page) { [weak self] response in
            guard let strongSelf = self else {
                return
            }
            strongSelf.hideLoader()
            switch response.result {
            case .success(let posts):
                strongSelf.dataSource = posts
                strongSelf.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UI

extension ViewController {
    
    private func showLoader() {
        activityIndicatorView.startAnimating()
    }
    
    private func hideLoader() {
        activityIndicatorView.stopAnimating()
    }
    
    private func showAlert(title: String, mesage: String) {
        let alertController = UIAlertController(title: title, message: mesage, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = dataSource[indexPath.row]
        let cell: UITableViewCell
        
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            cell = reusableCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        cell.textLabel?.text = item.titleText
        cell.detailTextLabel?.text = item.descriptionText
        
        return cell
    }
}

