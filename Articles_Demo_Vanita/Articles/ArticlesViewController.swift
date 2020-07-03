//
//  ArticlesViewController.swift
//  Articles_Demo_Vanita
//
//  Created by Vanita Ladkat on 02/07/20.
//  Copyright © 2020 Vanita Ladkat. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    @IBOutlet weak var articleTableView: UITableView!
    let viewModel = ArticlesViewModel()
    let spinner = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSpinner()
        fetchArticles()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articleTableView.rowHeight = UITableView.automaticDimension
        articleTableView.estimatedRowHeight = 400
    }

    func addSpinner() {
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        articleTableView.tableFooterView = spinner
    }

    func fetchArticles() {
        if InternetConnectionManager.isConnectedToNetwork() {
            spinner.startAnimating()
            viewModel.fetchArticles { [weak self] (success, error) in
                self?.spinner.stopAnimating()
                if success {
                    self?.articleTableView.reloadData()
                } else {
                    self?.showFailureAlert(error: error)
                }
            }
        }
    }

    func showFailureAlert(error: Error?) {
        let message = error?.localizedDescription ?? "Failed to get data"
        let alert = UIAlertController(title: "Failed", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as? ArticleTableViewCell {
            let article = viewModel.article(at: indexPath.row)
            cell.viewModel.article = article
            cell.configure()
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRows() -  1 {
            //reached ot last row fetch next page data:
            if viewModel.isAllDataFetched() == false {
                fetchArticles()
            }
        }
    }
}
