//
//  ViewController.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/08.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

enum ViewState {
    case up
    case down
    case moving
    case hidden
}

class ViewController: UIViewController {
    
    @IBOutlet weak var movieListTableView: UITableView!
    var videos: [Movie] = []
    var pageToken: String?
    var isAddLoad: Bool = true
    var scrollBeginPoint: CGFloat = 0.0
    var navigationBarIsHidden: Bool = false
    
    fileprivate let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        addData()
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.register(UINib(nibName: String(describing: HistoryTableViewCell.self) , bundle: nil), forCellReuseIdentifier: String(describing: HistoryTableViewCell.self))
        movieListTableView.register(UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MainTableViewCell.self))
        movieListTableView.register(UINib(nibName: String(describing: WaitingAnimationTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WaitingAnimationTableViewCell.self))
        movieListTableView.refreshControl = refreshControl
        movieListTableView.refreshControl?.addTarget(self, action: #selector(valueChanged(control:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationBarIsHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
        
    @objc func valueChanged(control: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.videos = []
            self.pageToken = nil
            self.addData()
            control.endRefreshing()
        }
    }
    
    func addData(pageToken: String? = nil) {
        YoutubeApiManager.shared.fetchVideos(pageToken: pageToken) { (result) in
            switch result {
            case .success(let videoList):
                if let videos = videoList?.videos  {
                    for video in videos {
                        self.videos.append(video)
                    }
                }
                self.pageToken = videoList?.nextPageToken
            case .failure(_):
                print("なぜ")
            }
            self.movieListTableView.reloadData()
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if videos.isEmpty {
            return 15
        }
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !videos.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self), for: indexPath) as! MainTableViewCell
            let video = videos[indexPath.row]
            cell.titleLabel.text = video.title
            let thumb = video.thumbnailHigh
            let image = UIImage(url: thumb.url)
            cell.thumbnailImage.image = image
            cell.channelNameLabel.text = video.channelTitle
            cell.dateLabel.text = video.publishedAt.toString(templete: .date)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WaitingAnimationTableViewCell.self),for: indexPath) as! WaitingAnimationTableViewCell
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollBeginPoint - scrollView.contentOffset.y
        updateNavigationBarHiding(scrollDiff: scrollDiff)
        if (movieListTableView.contentOffset.y + movieListTableView.frame.size.height > movieListTableView.contentSize.height && movieListTableView.isDragging && isAddLoad ) {
            self.isAddLoad = false
            movieListTableView.tableFooterView = LoadingView.view()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.movieListTableView.tableFooterView = UIView()
                self.addData(pageToken: self.pageToken)
                self.isAddLoad = true
                self.movieListTableView.tableFooterView = UIView()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollBeginPoint = scrollView.contentOffset.y
    }
    
    func updateNavigationBarHiding(scrollDiff: CGFloat) {
        let boundaryValue: CGFloat = 20.0

        if scrollDiff > boundaryValue {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationBarIsHidden = false
            let playerView = (navigationController as! NavigationViewController).playerView
            if let playerView = playerView {
                navigationController?.view.bringSubviewToFront(playerView)

            }
            return
        }
        if scrollDiff < -boundaryValue {
            navigationController?.setNavigationBarHidden(true, animated: true)
            navigationBarIsHidden = true
            return
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
}

