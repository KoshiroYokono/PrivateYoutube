//
//  PlayerView.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/17.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

enum stateOfVC {
    case minimized
    case fullScreen
    case hidden
}

protocol PlayerViewDelegate {
    func didAppear()
    func changePlayerViewState(with difference: CGFloat)
    func animateViewHeight()
    func closePlayerButton()
}

class PlayerView: UIView {
    var video: Movie?
    var state = stateOfVC.hidden
    var delegate: PlayerViewDelegate?
    var previousPosition: CGPoint!
    
    var viewState:ViewState = .up {
        didSet {
            delegate?.animateViewHeight()
        }
    }
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var underView: UIView!
    var youtubeView: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(tapPlayView), name: NSNotification.Name("open"), object: nil)
        setUpTableView()
        setUpYoutubeView()
    }
    
    static func view() -> PlayerView {
        let view = UINib(nibName: String(describing: PlayerView.self), bundle: .main).instantiate(withOwner: self, options: nil).first as! PlayerView
        return view
    }
    
    func resetPlayerView() {
        video = nil
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: String(describing: HeaderCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HeaderCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpYoutubeView() {
        youtubeView = YTPlayerView(frame: videoView.frame)
        youtubeView.delegate = self
        videoView.addSubview(youtubeView)
    }
    
    @IBAction func pangestureDidMoved(_ gesture: UIPanGestureRecognizer) {
        if gesture.numberOfTouches > 1 {
            return
        }
        switch gesture.state {
        case .began:
            previousPosition = gesture.location(in: nil)
        case .changed:
            if gesture.minimumNumberOfTouches > 1 {
                return
            }
            let changedPosition = gesture.location(in: nil)
            let movedY = changedPosition.y - previousPosition.y
            switch viewState {
            case .up:
                if movedY < 0 {
                    return
                }
            case .down:
                if movedY > 0 {
                    return
                }
            case .moving:
                break
            case .hidden:
                return
            }
            viewState = .moving
            delegate?.changePlayerViewState(with: movedY)
            previousPosition = changedPosition
        case .ended:
            let velocity = gesture.velocity(in: self).y
            if abs(velocity) > 1000 {
                if velocity > 0 {
                    viewState = .down
                } else {
                    viewState = .up
                }
            } else {
                let playerViewY = frame.origin.y
                if playerViewY <= UIScreen.main.bounds.height / 2 {
                    viewState = .up
                } else {
                    viewState = .down
                }
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
        default:
            break
        }
    }
    @objc func tapPlayView() {
        if let videoId = video?.videoId {
            youtubeView.load(withVideoId: videoId, playerVars: ["playsinline": 1])
            youtubeView.playVideo()
        }
        self.delegate?.didAppear()
    }
    @IBAction func closePlayerViewButtonDidTapped(_ sender: Any) {
        delegate?.closePlayerButton()
    }
}

extension PlayerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.row {
//        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            
            
            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        default:
            return 100
        }
    }
    
    
}

extension PlayerView: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) { playerView.playVideo() }
}
