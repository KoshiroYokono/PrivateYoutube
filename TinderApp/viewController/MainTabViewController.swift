//
//  MainTabViewController.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/12/20.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

class MainTabViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var channelButton: UIButton!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var navigationViewTopConstraint: NSLayoutConstraint!
    
    lazy var viewControllers:[UIViewController] = [
        UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateInitialViewController()!,
        UIStoryboard.init(name: "History", bundle: Bundle.main).instantiateInitialViewController()!,
        UIStoryboard.init(name: "Channel", bundle: Bundle.main).instantiateInitialViewController()!,
    ]
    
    private var currentTabPage: Int = 0 {
        didSet {
            containerView.subviews.forEach({$0.removeFromSuperview()})
            let vc = viewControllers[currentTabPage]
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(vc.view)
            addChild(vc)
            vc.willMove(toParent: self)
            
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        }
    }
    
    
    var playerView: PlayerView!
    var footerViewTop: NSLayoutConstraint!
    var playerViewHeight: NSLayoutConstraint!
    var playerViewBottomToFooter: NSLayoutConstraint!
    var playerViewWidth: NSLayoutConstraint!
    var playerViewGraterHeight: NSLayoutConstraint!
    var playerViewBottomToView: NSLayoutConstraint!
    
    var videoViewHeight: NSLayoutConstraint!
    var videoViewGraterHeight: NSLayoutConstraint!
    var videoViewWidth: NSLayoutConstraint!
        
    let hiddenOrigin: CGPoint = {
        return CGPoint.init(x: 0, y: UIScreen.main.bounds.height)
    }()
    let minimizedOrigin: CGFloat = 65
    let fullScreenOrigin = CGPoint.init(x: 0, y: 0)
    let videoHeightOrigin:CGFloat = UIScreen.main.bounds.width * (9 / 16)
    let footerHeightOrigin: CGFloat = 50
    
    var isStatusBarHidden: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTabPage = 0
        let buttons:[UIButton] = [homeButton,historyButton,channelButton]
        buttons.forEach { (button) in
            resizeImage(button: button)
        }
        setUpFooter()
        setUpPlayerView()
        setUpInnerView()
    }
    
    func setUpFooter() {
        footerView.translatesAutoresizingMaskIntoConstraints = false
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
        videoViewHeight = playerView.videoView.heightAnchor.constraint(equalToConstant: videoHeightOrigin)
        videoViewHeight.priority = UILayoutPriority(rawValue: 700)
        videoViewHeight.isActive = true
    }
    
    
    @IBAction func tabButtonDidTapped(_ sender: UIButton) {
        changeButtonSelection(button: sender)
        switch sender {
        case homeButton:
            currentTabPage = 0
        case historyButton:
            currentTabPage = 1
        case channelButton:
            currentTabPage = 2
        default:
            break
        }
    }
    
    private func changeButtonSelection(button: UIButton) {
        let buttons:[UIButton] = [homeButton,historyButton,channelButton]
        buttons.forEach { (btn) in
            if btn == button {
                btn.isSelected = true
                btn.tintColor = UIColor.red
//                btn.imageの変更
            } else {
                btn.isSelected = false
                btn.tintColor = UIColor.gray
            }
        }
    }
    
    func animatePlayView(toState: ViewState) {
            switch toState {
            case .up:
                isStatusBarHidden = true
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
                isStatusBarHidden = false
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
                isStatusBarHidden = false
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
    
    private func resizeImage(button: UIButton) {
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 10)
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

extension MainTabViewController: PlayerViewDelegate {
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
