//
//  NavigationViewController.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/17.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    var playerView: PlayerView!
    var footerView: NavigationFooterView!
    var footerViewTop: NSLayoutConstraint!
    var playerViewHeight: NSLayoutConstraint!
    var playerViewBottomToFooter: NSLayoutConstraint!
    var playerViewWidth: NSLayoutConstraint!
    var playerViewGraterHeight: NSLayoutConstraint!
    var playerViewBottomToView: NSLayoutConstraint!
    
    var videoViewHeight: NSLayoutConstraint!
    var videoViewGraterHeight: NSLayoutConstraint!
    
    let hiddenOrigin: CGPoint = {
        return CGPoint.init(x: 0, y: UIScreen.main.bounds.height)
    }()
    let minimizedOrigin: CGFloat = 65
    let fullScreenOrigin = CGPoint.init(x: 0, y: 0)
    let videoHeightOrigin:CGFloat = UIScreen.main.bounds.width * (9 / 16)
    let footerHeightOrigin: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpFooter()
        setUpPlayerView()
        setUpInnerView()
    }
    
    func setUpNavigationBar() {
        navigationBar.isTranslucent = false
        let titleView = UIImageView(image: #imageLiteral(resourceName: "youtube"))
        titleView.contentMode = .scaleAspectFit
        navigationBar.topItem?.titleView = titleView
        navigationBar.backgroundColor = .white
    }
    
    func setUpFooter() {
        footerView = NavigationFooterView.view()
        footerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(footerView)
        footerViewTop = footerView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -footerHeightOrigin)
        footerViewTop.isActive = true
        footerView.heightAnchor.constraint(equalToConstant: footerHeightOrigin).isActive = true
        footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    func setUpPlayerView() {
        playerView = PlayerView.view()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        view.trailingAnchor.constraint(greaterThanOrEqualTo: playerView.trailingAnchor).isActive = true
        view.leadingAnchor.constraint(lessThanOrEqualTo: playerView.leadingAnchor).isActive = true
        let trailing = view.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: 10)
        let leading = view.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: -10)
        view.centerXAnchor.constraint(equalTo: playerView.centerXAnchor).isActive = true
        let topAnchor = view.topAnchor.constraint(greaterThanOrEqualTo: playerView.topAnchor, constant: 0)
        playerViewWidth = playerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        playerViewHeight = playerView.heightAnchor.constraint(equalToConstant: 0)
        playerViewBottomToFooter = playerView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -10)
        playerViewBottomToView = view.bottomAnchor.constraint(equalTo: playerView.underView.topAnchor)
        trailing.isActive = true
        leading.isActive = true
        topAnchor.isActive = true
        playerViewWidth.isActive = true
        playerViewHeight.isActive = true
        playerViewBottomToFooter.isActive = true
        
        trailing.priority = UILayoutPriority(rawValue: 700)
        leading.priority = UILayoutPriority(rawValue: 700)
        topAnchor.priority = UILayoutPriority(rawValue: 500)
        playerViewWidth.priority = UILayoutPriority(rawValue: 700)
        playerViewHeight.priority = UILayoutPriority(rawValue: 800)
        playerView.delegate = self
        
        playerView.underView.isHidden = true
        
        playerViewGraterHeight =  playerView.heightAnchor.constraint(greaterThanOrEqualToConstant: minimizedOrigin)
        videoViewGraterHeight =  playerView.videoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 65)
    }
    
    func setUpInnerView() {
//        110
        videoViewHeight = playerView.videoView.heightAnchor.constraint(equalToConstant: videoHeightOrigin)
        videoViewHeight.priority = UILayoutPriority(rawValue: 700)
        videoViewHeight.isActive = true
    }
    
    func animatePlayView(toState: ViewState) {
        switch toState {
        case .up:
            playerViewHeight.constant = self.view.bounds.height
            playerViewWidth.constant = self.view.bounds.width
            videoViewHeight.constant = videoHeightOrigin
            footerViewTop.constant = 10
            if playerViewHeight.constant > 110 {
                playerView.underView.isHidden = true
            } else {
                playerView.underView.isHidden = false
            }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [.beginFromCurrentState], animations: {
                self.view.layoutIfNeeded()
            })

        case .down:
            playerViewHeight.constant = minimizedOrigin
            playerViewWidth.constant = self.view.bounds.width - 20
            videoViewHeight.constant = 65
            footerViewTop.constant = -footerHeightOrigin
            if playerViewHeight.constant > 110 {
                playerView.underView.isHidden = true
            } else {
                playerView.underView.isHidden = false
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        case .hidden:
//            playerViewHeight.constant = 0
//            videoViewHeight.constant = 0
            playerViewBottomToView.isActive = true
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        default:
            return
        }
    }
    
}

extension NavigationViewController: PlayerViewDelegate {
    func closePlayerButton() {
        playerViewBottomToView.isActive = true
        playerViewBottomToFooter.isActive = false
        playerViewGraterHeight.isActive = false
        videoViewGraterHeight.isActive = false
        playerView.resetPlayerView()
        animatePlayView(toState: .hidden)
    }
    
    
    func changePlayerViewState(with difference: CGFloat) {
        playerViewHeight.isActive = false
        playerViewHeight.constant -= difference
        playerViewHeight.isActive = true
        let footerRate = (playerViewHeight.constant - 65) / (view.bounds.height / 2)
        let videoViewRate = (videoHeightOrigin - 110) / (view.bounds.height - 110)
        videoViewHeight.constant -= difference * videoViewRate
        footerViewTop.constant = -footerHeightOrigin * (1 - footerRate)
        if playerViewHeight.constant > 110 {
            playerView.underView.isHidden = true
        } else {
            playerView.underView.isHidden = false
        }
    }
    
    func animateViewHeight() {
        animatePlayView(toState: playerView.viewState)
    }
    
    func didAppear() {
        playerViewGraterHeight.isActive = true
        videoViewGraterHeight.isActive = true
        playerViewBottomToFooter.isActive = false
        playerViewBottomToView.isActive = false
        animatePlayView(toState: .up)
        playerViewBottomToFooter.isActive = true
        view.bringSubviewToFront(footerView)
    }
}
