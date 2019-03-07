//
//  DiscussionViewController.swift
//  iOSFirebaseSample
//
//  Created by RD-WilleyLo on 2019/3/7.
//  Copyright © 2019 HungCLo. All rights reserved.
//

import UIKit

class DiscussionViewController: UIViewController {
    
    private var refreshControl = UIRefreshControl()
    private var movieReviews = [MovieReviewModel]()
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "下拉更新")
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshView()
    }
    
    @objc func refreshView() {
        FirebaseDBManager.sharedInstance().getChildValues(next: {[weak self](rawData) in
            guard let self = self else {return}
            self.refreshControl.endRefreshing()
            
            var newMovies = [MovieReviewModel]()
            for index in rawData {
                guard let item = index.value as? [AnyHashable: Any] else {continue}
                newMovies.append(MovieReviewModel(info: item))
            }
            self.movieReviews = newMovies
            self.tableview.reloadData()
        })
    }
}

extension DiscussionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CommentTableViewCell else {return UITableViewCell(frame: .zero)}
        cell.commentLabel.text = movieReviews[indexPath.row].movieReviews
        cell.createTimeLabel.text = movieReviews[indexPath.row].createTime
        return cell
    }
}

extension DiscussionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FirebaseDBManager.sharedInstance().removeChildValue(key: movieReviews[indexPath.row].childKey, next: {[weak self] () in
                guard let self = self else {return}
                self.refreshView()
            })
        }
    }
}
