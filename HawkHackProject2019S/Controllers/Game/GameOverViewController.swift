//
//  GameOverViewController.swift
//  HawkHackProject2019S
//
//  Created by Samuel Folledo on 5/14/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertNavigationView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var experienceGainedLabel: UILabel!
    @IBOutlet weak var coinsGainedLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
//    var didWin: Bool?
//    {
//        didSet {
//            if let won = didWin {
//                print("won has value")
//                self.backgroundImageView.image = won == true ? UIImage(named: "youWin.jpg") : UIImage(named: "youLose.png")
//            }
//        }
//    }
    
    var game: Game?
    var opponentUser: User?
    var previousExp: Int?
    let gainedExpShapeLayer: CAShapeLayer = CAShapeLayer() //for expBar
    let currentExpShapeLayer: CAShapeLayer = CAShapeLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImageView.image = game?.winnerUid == User.currentId() ? UIImage(named: "youWin.jpg") : UIImage(named: "youLose.png")
//        if let won = didWin {
//            print("won has value")
//            self.backgroundImageView.image = won == true ? UIImage(named: "youWin.jpg") : UIImage(named: "youLose.png")
//        }
        
        let imageUrl: String = User.currentUser()!.avatarURL
        self.profileImageView.downloaded(fromLink: "\(imageUrl)")
        self.profileImageView.layer.cornerRadius = 25 //half of the imageView to make it round
        self.profileImageView.layer.masksToBounds = true
        
        self.coinsGainedLabel.text = game?.winnerUid == User.currentId() ? "+10" : "+1"
        self.experienceGainedLabel.text = game?.winnerUid == User.currentId() ? "+100" : "+10"
        
        self.previousExp = game?.winnerUid == User.currentId() ? User.currentUser()!.experience - 100 : User.currentUser()!.experience - 10
        
        
//experience bar
        let center = profileImageView.center
    //trackLayer
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 30/2, startAngle: 0.8 * CGFloat.pi, endAngle: 2.2 * CGFloat.pi, clockwise: true) //path to draw itself, 2 pi
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 2
        trackLayer.lineCap = CAShapeLayerLineCap.round //kCALineCapRound changed to CAShapeLayerLineCap.round
        alertNavigationView.layer.addSublayer(trackLayer)
        
    //previousExp to currentExp layer
        currentExpShapeLayer.path = circularPath.cgPath
        currentExpShapeLayer.fillColor = UIColor.clear.cgColor
        currentExpShapeLayer.strokeColor = UIColor.yellow.cgColor
        currentExpShapeLayer.lineWidth = 4
        currentExpShapeLayer.lineCap = CAShapeLayerLineCap.round //kCALineCapRound changed to CAShapeLayerLineCap.round
//        alertNavigationView.layer.addSublayer(currentExpShapeLayer)
        
    //gained experience bar layer
        gainedExpShapeLayer.path = circularPath.cgPath
        gainedExpShapeLayer.fillColor = UIColor.clear.cgColor
        gainedExpShapeLayer.strokeColor = UIColor.green.cgColor
        gainedExpShapeLayer.lineWidth = 4
        gainedExpShapeLayer.lineCap = CAShapeLayerLineCap.round //kCALineCapRound changed to CAShapeLayerLineCap.round
//        gainedExpShapeLayer.strokeEnd = 0
        alertNavigationView.layer.addSublayer(gainedExpShapeLayer)
        alertNavigationView.layer.addSublayer(currentExpShapeLayer)
        showExperienceBarAnimation()
        
    }
    
    func showExperienceBarAnimation() {
        guard let user = User.currentUser() else { print("no user"); return }
        let maxExp: CGFloat = CGFloat(getMaxExperienceNeeded(fromLevel: user.level))
        
        let previousExp: CGFloat = game?.winnerUid == user.userID ? CGFloat(user.experience - 100) : CGFloat(user.experience - 10)
        let startAngle: CGFloat = previousExp / maxExp
        currentExpShapeLayer.strokeEnd = startAngle
        gainedExpShapeLayer.strokeEnd = startAngle
        
        let currentExp: CGFloat = CGFloat(user.experience)
        let toValue: CGFloat = currentExp / maxExp
        
    //create the animation
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = toValue
        basicAnimation.duration = 1 //time in seconds animation
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards //kCAFillModeForwards been replaced by CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        gainedExpShapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true //hide nav controller
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        let preGameVC: PreGameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kPREGAMEVIEWCONTROLLER) as! PreGameViewController
//        self.navigationController?.popToViewController(preGameVC, animated: true)
        game?.deleteGame(game: game!, completion: { (error) in
            if let error = error {
                Service.presentAlert(on: self, title: "Error Deleting", message: error)
            } else {
                
//                self.navigationController?.popToViewController(preGameVC, animated: true)
            }
        })
        
        game?.addGameToHistory(game: game!, completion: { (error) in
            if let error = error {
                Service.presentAlert(on: self, title: "Error Adding to History", message: error)
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        
        let userId = User.currentId()
        let opponentUid = userId == game!.player1Id ? game!.player2Id : game!.player1Id //opponentUid if currentUserId is == p1Id, then opponentUid is p2Id, else p1Id
        
        fetchOpponentUserWith(opponentUid: opponentUid!) { (opponentUser) in
            
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
