//
//  CurrentGameViewController.swift
//  HawkHackProject2019S
//
//  Created by Samuel Folledo on 4/1/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

struct RyuAnimationName {
    static let Intro = ("ryuIntro", 19) //last frame is 18 and +1 = 19
    static let Standing = ("ryu", 6) //because frames only goes from 0-5
    static let Jump = ("ryuJump", 34) //needs to be sped up
    
    static let RyuPunchHighLight = ("ryuPunchHL", 6) //high light
    static let RyuPunchHighMedium = ("ryuPunchHM", 8) //high medium
    static let RyuPunchHighHard = ("ryuPunchHH", 13) //high hard
    static let RyuPunchLowLight = ("ryuPunchLL", 7) //low light
    static let RyuPunchLowMedium = ("ryuPunchLM", 11) //low medium
    static let RyuPunchLowHard = ("ryuPunchLH", 11) //low hard
    
    static let RyuPunchHighFinisher = ("ryuPunchHighFinisher", 25) //high finisher
    static let RyuPunchLowFinisher = ("ryuPunchLowFinisher", 47) //low finisher
    
    static let RyuKickHighLight = ("ryuKickHL", 11) //high light
    static let RyuKickHighMedium = ("ryuKickHM", 15)
    static let RyuKickHighHard = ("ryuKickHH", 27)
    static let RyuKickLowLight = ("ryuKickLL", 7) //low light
    static let RyuKickLowMedium = ("ryuKickLM", 11)
    static let RyuKickLowHard = ("ryuKickLH", 13)
    
    static let RyuKickHighFinisher = ("ryuKickHighFinisher", 53) //high finisher
    static let RyuKickLowFinisher = ("ryuKickLowFinisher", 39)//low finisher
    
    //    static let Jump = ("ryuJumpPunch", 32)
    //    static let Punch = ("ryuJumpPunch", 32)
}

struct KenAnimationName {
    static let KenIntro = ("kenIntro", 8) //last frame is 18 and +1 = 19
    static let KenStanding = ("kenStanding", 10)
    static let KenJump = ("kenJump", 34)
    
    static let KenPunchHighLight = ("kenPunchHL", 5) //high light
    static let KenPunchHighMedium = ("kenPunchHM", 9)
    static let KenPunchHighHard = ("kenPunchHH", 12)
    static let KenPunchLowLight = ("kenPunchLL", 6) //low light
    static let KenPunchLowMedium = ("kenPunchLM", 11)
    static let KenPunchLowHard = ("kenPunchLH", 27)
    
    static let KenPunchHighFinisher = ("kenPunchHighFinisher", 58) //high finisher
    static let KenPunchLowFinisher = ("kenPunchLowFinisher", 51) //low finisher
    
    static let KenKickHighLight = ("kenKickHL", 16) //high light
    static let KenKickHighMedium = ("kenKickHM", 14)
    static let KenKickHighHard = ("kenKickHH", 21)
    static let KenKickLowLight = ("kenKickLL", 6) //low light
    static let KenKickLowMedium = ("kenKickLM", 10)
    static let KenKickLowHard = ("kenKickLW", 27)
    
    static let KenKickHighFinisher = ("kenKickHighFinisher", 51) //high finisher
    static let KenKickLowFinisher = ("kenKickLowFinisher", 115) //low finisher
    
}

struct ButtonAnimations {
	static let None = ("", 0)
	static let SmallFire = ("smallFire", 23)
	static let BigFire = ("bigFire", 15)
}

class CurrentGameViewController: UIViewController {
	
//MARK: IBOutlets
	@IBOutlet weak var backgroundImageView: UIImageView!
	@IBOutlet weak var gameSessionLabel: UILabel!
	@IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var roundNumberLabel: UILabel!
	
	@IBOutlet weak var player1NameLabel: UILabel!
	@IBOutlet weak var player1ImageView: UIImageView!
	@IBOutlet weak var player1HPLabel: UILabel!
	@IBOutlet weak var player1DamageLabel: UILabel!
	@IBOutlet weak var player1Character: UIImageView!
	@IBOutlet weak var player1MovesView: MyView!
	@IBOutlet weak var player1HPBar: UIProgressView!
    @IBOutlet weak var player1IsFirstImageView: UIImageView!
    
    
	@IBOutlet weak var player2NameLabel: UILabel!
	@IBOutlet weak var player2ImageView: UIImageView!
	@IBOutlet weak var player2HPLabel: UILabel!
	@IBOutlet weak var player2DamageLabel: UILabel!
	@IBOutlet weak var player2Character: UIImageView!
	@IBOutlet weak var player2MovesView: MyView!
	@IBOutlet weak var player2HPBar: UIProgressView!
    @IBOutlet weak var player2IsFirstImageView: UIImageView!
    
	@IBOutlet weak var p1Button10Up: MovesButton!
	@IBOutlet weak var p1Button11Back: MovesButton!
	@IBOutlet weak var p1Button12Down: MovesButton!
	@IBOutlet weak var p1Button13Forward: MovesButton!
	@IBOutlet weak var p1Button14LUp: MovesButton!
	@IBOutlet weak var p1Button15MUp: MovesButton!
	@IBOutlet weak var p1Button16HUp: MovesButton!
	@IBOutlet weak var p1Button17LDown: MovesButton!
	@IBOutlet weak var p1Button18MDown: MovesButton!
	@IBOutlet weak var p1Button19HDown: MovesButton!
	
	@IBOutlet weak var p1Button14ImageView: UIImageView!
	@IBOutlet weak var p1Button15ImageView: UIImageView!
	@IBOutlet weak var p1Button16ImageView: UIImageView!
	@IBOutlet weak var p1Button17ImageView: UIImageView!
	@IBOutlet weak var p1Button18ImageView: UIImageView!
	@IBOutlet weak var p1Button19ImageView: UIImageView!
	
	
	@IBOutlet weak var p2Button20Up: MovesButton!
	@IBOutlet weak var p2Button21Forward: MovesButton!
	@IBOutlet weak var p2Button22Down: MovesButton!
	@IBOutlet weak var p2Button23Back: MovesButton!
	@IBOutlet weak var p2Button24HUp: MovesButton!
	@IBOutlet weak var p2Button25MUp: MovesButton!
	@IBOutlet weak var p2Button26LUp: MovesButton!
	@IBOutlet weak var p2Button27HDown: MovesButton!
	@IBOutlet weak var p2Button28MDown: MovesButton!
	@IBOutlet weak var p2Button29LDown: MovesButton!
	
	@IBOutlet weak var p2Button24ImageView: UIImageView!
	@IBOutlet weak var p2Button25ImageView: UIImageView!
	@IBOutlet weak var p2Button26ImageView: UIImageView!
	@IBOutlet weak var p2Button27ImageView: UIImageView!
	@IBOutlet weak var p2Button28ImageView: UIImageView!
	@IBOutlet weak var p2Button29ImageView: UIImageView!
	
	
//MARK: Properties
	var game: Game?
//    var round: CurrentRound?
//    var p1Round: CurrentRound?
//    var p2Round: CurrentRound?
    
	var player1TagSelected: (move: Int?, attack: Int?)
	var player2TagSelected: (move: Int?, attack: Int?)
	
	var p1MoveResult: (damage: Int?, damageMultiplier: CGFloat?, defenseMultiplier: CGFloat?, speed: CGFloat?)
	var p2MoveResult: (damage: Int?, damageMultiplier: CGFloat?, defenseMultiplier: CGFloat?, speed: CGFloat?)
	
	var player1MoveButtons: [MovesButton]?
	var player1AttackButtons: [MovesButton]?
	var player2MoveButtons: [MovesButton]?
	var player2AttackButtons: [MovesButton]?
	var allButtons: [MovesButton]?
	
	var kenCounter = 0
	var kenTimer: Timer?
    var kenImageName = KenAnimationName.KenStanding
	
	var ryuImageName = RyuAnimationName.Standing
	var ryuCounter = 0
	var ryuTimer: Timer?
	
	var backgroundCounter = 0
	var bgMaxCounter: Int = 0
	var backgroundTimer: Timer?
	var backgroundName: String = ""
//    var player1Hp: Int = 30
//    var player2Hp: Int = 30
	
	var clockTimer: Timer?
	var clockCounter: Int = 8
//    var turnCount: Int = 0
	
	let player1HPProgress = Progress(totalUnitCount: 30)
	let player2HPProgress = Progress(totalUnitCount: 30)
	
	var smallFireTimer: Timer?
	var smallFireCounter = 0
	var bigFireTimer: Timer?
	var bigFireCounter = 0
	
	var isAgainstOnlineUser: Bool = false
    var p1HasSpeedBoost = false
    var fetchingOpponentMoveTimer: Timer?
	
//MARK: LifeCycle -----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		setupPlayersButtons()
		
		setupBackgroundImageView()
		
        
        backgroundTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.backgroundAnimation), userInfo: nil, repeats: true) //to run and animate the background every 0.1 seconds
        ryuTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.ryuStandingAnimation), userInfo: nil, repeats: true) //run ryu's timer to animate his movements
        kenTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.kenStandingAnimation), userInfo: nil, repeats: true) //run ken's timer to begin animating his movements
        
        player2Character.transform = CGAffineTransform(scaleX: -1, y: 1) //since p2CharacterImageView (ken's) images faces to the right, this will flip it horizontally
        
		player1HPBar.transform = CGAffineTransform(scaleX: -1, y: 1) //since hp bar fills up like a loading bar, transform scaleX -1 will flip it, making it work like an HP bar
		player2HPBar.transform = CGAffineTransform(scaleX: -1, y: 1)
		player1HPBar.transform = player1HPBar.transform.scaledBy(x: 1, y: 10) // y will also control the height, and x will also control the width
		player2HPBar.transform = player2HPBar.transform.scaledBy(x: 1, y: 10)
		
		
		
		
		updateViewWithGame(currentGame: game!)
		
		
        game?.roundNumber = 1 //make game's roundNumber = 1 and update offline and online
        UserDefaults.standard.set(gameDictionaryFrom(game: game!), forKey: game!.gameId)
        UserDefaults.standard.synchronize() //saving it locally
        self.roundNumberLabel.text = "\(game!.roundNumber)" //present it to the user
        updateCurrentGame(game: game!, withValues: [kROUNDNUMBER: game!.roundNumber]) { (error) in
            if let error = error {
                Service.presentAlert(on: self, title: "Error", message: error)
                return
            } else {
//                print("\n\nGame is \(gameDictionaryFrom(game: self.game!))\n\n")
            }
        }
		startTurnTimer()
        
//        uploadGameToFirebase(withGame: game!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		backgroundTimer?.invalidate()
		clockTimer?.invalidate()
		ryuTimer?.invalidate()
		kenTimer?.invalidate()
        fetchingOpponentMoveTimer?.invalidate()
        firDatabase.removeAllObservers()
	}
    
//prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toGameOverSegue":
//            guard let didUserWin = sender as? Bool else { return }
            let gameOverVC: GameOverViewController = segue.destination as! GameOverViewController
//            gameOverVC.didWin = didUserWin
            gameOverVC.game = game //pass the game to gameOVer
        default:
            break
        }
    }
    
	
	private func putAnimation(button: MovesButton, animation: (String,Int)) { //a method that takes a button and an animation. It will then assign the animation (with the right images and duration) to the button. Then it will animate those images appended to images array
//		if button.cooldown > 1 { return }
		var images: [UIImage] = [] //contains the images for the animation
		var duration: Double = 0
		button.animation = animation //assign the button's animation
        if button.animation == ButtonAnimations.None {
			duration = 0
			button.damageMultiplier = 1
		} else if button.animation == ButtonAnimations.SmallFire {
			duration = 2.3 //because smallFire has 23 frames getting played every 0.1 secs
			button.damageMultiplier *= 1.5
			for i in 0 ... ButtonAnimations.SmallFire.1 {
				images.append(UIImage(named: "\(ButtonAnimations.SmallFire.0)\(i)")!) //
			}
		} else if button.animation == ButtonAnimations.BigFire {
			duration = 1.5
			button.damageMultiplier *= 2.0
			for i in 0 ... ButtonAnimations.BigFire.1 {
				images.append(UIImage(named: "\(ButtonAnimations.BigFire.0)\(i)")!)
			}
		} else { print("weird button animations") }
		
		switch button { //which ever button is passed, animate it
		case p1Button14LUp:
			p1Button14ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p1Button15MUp:
			p1Button15ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p1Button16HUp:
			p1Button16ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p1Button17LDown:
			p1Button17ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p1Button18MDown:
			p1Button18ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p1Button19HDown:
			p1Button19ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p2Button24HUp:
			p2Button24ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p2Button25MUp:
			p2Button25ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p2Button26LUp:
			p2Button26ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p2Button27HDown:
			p2Button27ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p2Button28MDown:
			p2Button28ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		case p2Button29LDown:
			p2Button29ImageView.image = UIImage.animatedImage(with: images, duration: duration)
		default:
			break
		}
		
//		button.setBackgroundImage(UIImage.animatedImage(with: images, duration: duration), for: .normal)
	}
	
	
//MARK: Private methods -----------------------------------------------------
	private func setupPlayersButtons() { //sets up the attributes of the buttons
		player1MoveButtons = [p1Button10Up, p1Button11Back, p1Button12Down, p1Button13Forward]
		player1AttackButtons = [p1Button14LUp, p1Button15MUp, p1Button16HUp, p1Button17LDown, p1Button18MDown, p1Button19HDown]
		
		player2MoveButtons = [p2Button20Up, p2Button21Forward, p2Button22Down, p2Button23Back]
		player2AttackButtons = [p2Button24HUp, p2Button25MUp, p2Button26LUp, p2Button27HDown, p2Button28MDown, p2Button29LDown]
		
		self.allButtons = (player1MoveButtons! + player1AttackButtons! + player2MoveButtons! + player2AttackButtons!)
		
		p1Button10Up.buttonTag = 10
		p1Button11Back.buttonTag = 11
		p1Button12Down.buttonTag = 12
		p1Button13Forward.buttonTag = 13
		
		p1Button14LUp.buttonTag = 14
		p1Button14LUp.damage = 10
		
		p1Button15MUp.buttonTag = 15
		p1Button15MUp.damage = 15
		
		p1Button16HUp.buttonTag = 16
		p1Button16HUp.damage = 20
		
		p1Button17LDown.buttonTag = 17
		p1Button17LDown.damage = 10
		
		p1Button18MDown.buttonTag = 18
		p1Button18MDown.damage = 15
		
		p1Button19HDown.buttonTag = 19
		p1Button19HDown.damage = 20
		
		p2Button20Up.buttonTag = 20
		p2Button21Forward.buttonTag = 21
		p2Button22Down.buttonTag = 22
		p2Button23Back.buttonTag = 23
		
		p2Button24HUp.buttonTag = 24
		p2Button24HUp.damage = 20
		
		p2Button25MUp.buttonTag = 25
		p2Button25MUp.damage = 15
		
		p2Button26LUp.buttonTag = 26
		p2Button26LUp.damage = 10
		
		p2Button27HDown.buttonTag = 27
		p2Button27HDown.damage = 20
		
		p2Button28MDown.buttonTag = 28
		p2Button28MDown.damage = 15
		
		p2Button29LDown.buttonTag = 29
		p2Button29LDown.damage = 10
	}
	
	private func startTurnTimer() { //A method that sets up the beginning of the round
//        game?.roundNumber
//        self.roundNumberLabel.text = "\(game?.roundNumber)"
        player1IsFirstImageView.isHidden = !p1HasSpeedBoost //if p1IsFirstImageView will be hidden if p1HasSpeedBoost == false
        player2IsFirstImageView.isHidden = p1HasSpeedBoost
        print("p1 is hidden  = \(!p1HasSpeedBoost)\np2 is hidden = \(p1HasSpeedBoost)")
        
        if p1HasSpeedBoost { //gives a +1 speed boost to whichever player has the speed boost
            p1MoveResult = (damage:0, damageMultiplier:CGFloat(1), defenseMultiplier:CGFloat(1), speed: CGFloat(1)) //give p1MoveResults a +1 speed boost
            p2MoveResult = (damage:0, damageMultiplier:1, defenseMultiplier:1, speed:0)
        } else {
            p2MoveResult = (damage:0, damageMultiplier:CGFloat(1), defenseMultiplier:CGFloat(1), speed: CGFloat(1)) //give p2 +1 speed boost
            p1MoveResult = (damage:0, damageMultiplier:1, defenseMultiplier:1, speed:0)
        }
        
        
		clockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTurnTime), userInfo: nil, repeats: true) //Once the round is ready, start the timer
	}
	
    
    
    private func setupSelectedTag() {
//        p1MoveResult = (damage:0, damageMultiplier:1, defenseMultiplier:1, speed:0)
//        p2MoveResult = (damage:0, damageMultiplier:1, defenseMultiplier:1, speed:0)
        player1MovesView.isUserInteractionEnabled = false
        player2MovesView.isUserInteractionEnabled = false
        
        if !isAgainstOnlineUser {
            
            self.applyDamagesToViews(completion: {
                self.player1DamageLabel.isHidden = true
                self.player2DamageLabel.isHidden = true
                
                if self.game?.winnerUid == nil || self.game?.winnerUid == "" {
                    self.finishTurn()
                    
                } else { //if isGameOver is not nil
//                    print("we have results! \(self.game?.winnerUid)")
                    self.gameOver() //pass either if p1 or p2 wins
                }
            })
//            return
            
        } else { //if we are playing against someone online...
            if User.currentId() == self.game?.player1Id { //if our current user is p1 then upload p1's selectedTag and fetch p2's selectedTag
                self.player1TagSelected.move = player1TagSelected.move == nil ? 1 : player1TagSelected.move
                self.player1TagSelected.attack = player1TagSelected.attack == nil ? 1 : player1TagSelected.attack //ifuser didnt select a move, we will upload 1 instead of the buttonTag
                
                uploadCurrentUserSelectedTag(gameSessionId: game!.gameId, p1OrP2String: "p1", turnCount: game!.roundNumber, currentUserTag: (player1TagSelected.move!, player1TagSelected.attack!)) { (error) in //we can safely force unwrap tagSelected because we said to equal it to 1 if it is nil
                    if let error = error {
                        Service.presentAlert(on: self, title: "Error Uploading User Selected Tag", message: error.localizedDescription)
                        return
                    } else {
                        self.fetchOpponentSelectedTag(gameSessionId: self.game!.gameId, p1OrP2String: "p2")
                    }
                }
            } else if User.currentId() == self.game?.player2Id { //if our current user is p2 then upload p2's selectedTag and fetch p1's selectedTag
                self.player2TagSelected.move = player2TagSelected.move == nil ? 1 : player2TagSelected.move //if user didnt select a move, we will upload 1 instead of the buttonTag
                self.player2TagSelected.attack = player2TagSelected.attack == nil ? 1 : player2TagSelected.attack //ifuser didnt select a move, we will upload 1 instead of the buttonTag
                
                uploadCurrentUserSelectedTag(gameSessionId: game!.gameId, p1OrP2String: "p2", turnCount: game!.roundNumber, currentUserTag: (player2TagSelected.move!, player2TagSelected.attack!)) { (error) in
                    if let error = error {
                        Service.presentAlert(on: self, title: "Error Uploading User Selected Tag", message: error.localizedDescription)
                        return
                    } else {
                        self.fetchOpponentSelectedTag(gameSessionId: self.game!.gameId, p1OrP2String: "p1")
                    }
                }
            }
        }
    }
    
    
    func fetchOpponentSelectedTag(gameSessionId: String, p1OrP2String: String) {
        let ref =  firDatabase.child(kGAMESESSIONS).child(gameSessionId).child(kCURRENTGAME).child(kROUNDS).child("\(String(game!.roundNumber))")
        ref.observe(.value, with: { (snapshot) in
            print("Hey something was added at currentGame turn #\(self.game!.roundNumber)")
            if snapshot.exists() && snapshot.childrenCount == 4 { //if it exist and it has 4 children (p1Move, p1Attack, p2Move, p2Attack)...
                ref.removeAllObservers() // if snapshot is acceptable then remove the observer and the timer
                self.fetchingOpponentMoveTimer?.invalidate()
                //            let userDictionary = ((snapshot.value as! NSDictionary).allValues as NSArray).firstObject! as! [String: AnyObject]
//                print("SNAPSHOT is \(snapshot)")
                guard let resultDic = snapshot.value as? [String: AnyObject] else {
                    //                completion((0,0))
//                    print("2")
                    return
                }
                print("Result Dic is \(resultDic)")
                guard let fetchedOpponentMove = resultDic["\(p1OrP2String)MoveTag"] as? Int else {
                    print("No opponentMove found");
                    return
                }
                guard let fetchedOpponentAttack = resultDic["\(p1OrP2String)AttackTag"] as? Int else { print("No opponentAttack found"); return }
                
                
                if p1OrP2String == "p1" {
                    self.player1TagSelected = (fetchedOpponentMove, fetchedOpponentAttack) //assign our fetched opponentMove to our p1
                    for button in self.player1AttackButtons! where self.player1TagSelected.attack == button.buttonTag { //declare that they are a selected button
                        button.selectedButton = true
                    }
                    for button in self.player1MoveButtons! where self.player1TagSelected.move == button.buttonTag {
                        button.selectedButton = true
                    }
                    
                } else {
                    self.player2TagSelected = (fetchedOpponentMove, fetchedOpponentAttack)
                    for button in self.player2AttackButtons! where self.player2TagSelected.attack == button.buttonTag {
                        button.selectedButton = true
                    }
                    for button in self.player2MoveButtons! where self.player2TagSelected.move == button.buttonTag {
                        button.selectedButton = true
                    }
                }
                
//            print("applying damage to views")
                self.applyDamagesToViews(completion: { //now after 2 seconds after delay of giving a value to optional game.winnerUid
                    
                    self.player1DamageLabel.isHidden = true //hide hp damage label
                    self.player2DamageLabel.isHidden = true
                    
                    if self.game?.winnerUid == nil || self.game?.winnerUid == "" { //if winnerUid is nil then continue the turn cuz game is not over
                        self.finishTurn()
                        
                    } else { //if we have a game.winnerUid!!! so game over
                        self.player1HPLabel.text = self.game?.player1Id == self.game?.winnerUid ? "WIN!" : "LOSE"
                        self.player2HPLabel.text = self.game?.player2Id == self.game?.winnerUid ? "WIN!": "LOSE"

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { //delay
//                            print("we have results! \(self.game?.winnerUid)")
                            self.gameOver() //run gameOver
                        })
                    }
                })
                
                
            } else { //snapshot dont exist or not all 4 moves are available
                print("fetched opponent selected tag, all 4 moves are not available as snapshot")
                self.player1MovesView.isUserInteractionEnabled = false
                self.player2MovesView.isUserInteractionEnabled = false
                self.fetchingOpponentMoveTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)// Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
            }
        }, withCancel: nil)
    }
    
    
    @objc func updateCounting() {
        print("waiting for opponent's move...")
    }
	
    private func applyDamagesToViews(completion: @escaping () -> Void) { //or () -> ()
        getPlayer1Damage()
        getPlayer2Damage()
        getEnemyDefense()
        
        ryuCounter = 0
        
        
        
        //get p1 and p2 damage
        var player1Damage = Int(CGFloat(p1MoveResult.damage!) * p1MoveResult.damageMultiplier! * p2MoveResult.defenseMultiplier!)
        var player2Damage = Int(CGFloat(p2MoveResult.damage!) * p2MoveResult.damageMultiplier! * p1MoveResult.defenseMultiplier!)
        
    
        if p1MoveResult.speed! > p2MoveResult.speed! { //if p1 is first then lower p2's damage
            switch player1TagSelected.attack {
            case 14, 17:
                player2Damage = Int(CGFloat(player2Damage) * 0.9) //if light attacks were used, reduce opponent's damage by 10%
            case 15, 18:
                player2Damage = Int(CGFloat(player2Damage) * 0.8) //if light attacks were used, reduce opponent's damage by 10%
            case 16, 19:
                player2Damage = Int(CGFloat(player2Damage) * 0.7) //if light attacks were used, reduce opponent's damage by 10%
            case .none, 1: //if user picked nothing then dont reduce damage
                print("p1 user didn't select an attack")
            default:
                print("Weird p1 tag")
            }
        }
        
        if p2MoveResult.speed! > p1MoveResult.speed! { //if p2 is first then reduce p1's damage
            switch player2TagSelected.attack {
            case 24, 27:
                player1Damage = Int(CGFloat(player1Damage) * 0.9) //if light attacks were used, reduce opponent's damage by 10%
            case 25, 28:
                player1Damage = Int(CGFloat(player1Damage) * 0.8) //if light attacks were used, reduce opponent's damage by 10%
            case 26, 29:
                player1Damage = Int(CGFloat(player1Damage) * 0.7) //if light attacks were used, reduce opponent's damage by 10%
            case .none, 1: //if user picked nothing then dont reduce damage
                print("p2 user didn't select an attack")
            default:
                print("Weird p2 tag")
            }
        }
        
        //            print("P1 Damage = \(player1Damage)\nP2 Damage = \(player2Damage)")
        //            print("P1 speed = \(p1MoveResult.speed)\nP2 speed = \(p2MoveResult.speed)")
        //        print("P1 \(p1MoveResult)\nP2 \(p2MoveResult)")
        
        
        if player1Damage > 0 { //displays the damage if p1's damage is greater than 0
            player2DamageLabel.text = "-\(player1Damage)"
            player2DamageLabel.isHidden = false
            player2DamageLabel.pulsate()
        }
        if player2Damage > 0 {
            player1DamageLabel.text = "-\(player2Damage)"
            player1DamageLabel.isHidden = false
            player1DamageLabel.pulsate()
        }
        
        
        if CGFloat(p1MoveResult.speed!) > CGFloat(p2MoveResult.speed!) { //if p1 first
            //            print("p1 first")
            self.game!.player2HP -= player1Damage
            self.player2HPProgress.completedUnitCount += Int64(player1Damage)
            let player2ProgressFloat = Float(self.player2HPProgress.fractionCompleted)
            self.player2HPBar.setProgress(player2ProgressFloat, animated: true)
            
            p1HasSpeedBoost = true //set it to true so we can give p1 a +1 speed for next turn
//            player2Damage = Int(CGFloat(player2Damage) * 0.9) //gives a little incentive to go first by reducing damage received by 10% if a player moves first
            
            if game!.player2HP > 0 { //if p2 is still alive
                self.game!.player1HP -= player2Damage
                self.player1HPProgress.completedUnitCount += Int64(player2Damage)
                let player1ProgressFloat = Float(self.player1HPProgress.fractionCompleted)
                self.player1HPBar.setProgress(player1ProgressFloat, animated: true)
                
                if game!.player1HP <= 0 { //if p1 dies
                    game?.winnerUid = game?.player2Id
//                    completion(false)
                } else {
                    self.player1HPLabel.text = "\(game!.player1HP)/30"
                    self.player2HPLabel.text = "\(game!.player2HP)/30"
                }
            } else { //if p2 dies
                game?.winnerUid = game?.player1Id
//                completion(true)
            }
            
        } else { //if p2 first
            //            print("p2 first")
            self.game!.player1HP -= player2Damage
            self.player1HPProgress.completedUnitCount += Int64(player2Damage)
            let player1ProgressFloat = Float(self.player1HPProgress.fractionCompleted)
            self.player1HPBar.setProgress(player1ProgressFloat, animated: true)
            
            p1HasSpeedBoost = false //p2 will have +1 speed boost
//            player1Damage = Int(CGFloat(player1Damage) * 0.9)
            
            if game!.player1HP > 0 { //if p1 is still alive
                self.game!.player2HP -= player1Damage
                self.player2HPProgress.completedUnitCount += Int64(player1Damage)
                let player2ProgressFloat = Float(self.player2HPProgress.fractionCompleted)
                self.player2HPBar.setProgress(player2ProgressFloat, animated: true)
                
                if game!.player2HP <= 0 { //if p2 dies
                    game?.winnerUid = game?.player1Id
//                    completion(true)
//                    return
                } else {
                    self.player1HPLabel.text = "\(game!.player1HP)/30"
                    self.player2HPLabel.text = "\(game!.player2HP)/30"
                }
                
            } else { //if p1 dies
                game?.winnerUid = game?.player2Id
//                completion(false)
            }
        }
        
        
        
        if isAgainstOnlineUser { //if we are against an online user then save locally
            updateCurrentGame(game: game!, withValues: ["round\(game!.roundNumber)": [player1TagSelected.move, player1TagSelected.attack, player2TagSelected.move, player2TagSelected.attack, game!.player1HP, game!.player2HP]]) { (error) in //update the game in background in Firebase
                if let error = error {
                    Service.presentAlert(on: self, title: "Updating Round Error", message: error)
                    return
                }
            }
        }
        
        completion()
    }
    
    
    private func gameOver() {
//remove game reference here
        print("update and remove game reference here")
        let currentUser = User.currentUser()!
        if !isAgainstOnlineUser { //if we are not against another user, update user and delete reference to the game
            increaseExperience(user: currentUser, gained: 1, completion: { //increase user's experience by 1
                let statsValues: [String: Int] = [kEXPERIENCES: currentUser.experience, kLEVEL: currentUser.level] //if currentUser won, then increase win by 1 and exp by 100 || lose by 1 and exp by 10
                
                updateCurrentUser(withValues: statsValues, withBlock: { (hasError) in //updateCurrent User first with statsValues then update the userRef
                    if !hasError {
                        Service.presentAlert(on: self, title: "Error", message: "Error updating user")
                    }
                })
            })
            game?.deleteGame(game: game!, completion: { (error) in //delete the game
                if let error = error  {
                    Service.presentAlert(on: self, title: "Error", message: error)
                }
            })
            
        } else { //if we are playing online then we update the user, add game to GameHistory and delete the game
            game!.saveUserFromGameResult(game: game!) { (error) in
                if let error = error {
                    Service.presentAlert(on: self, title: "Upload Error", message: error)
                    return
                } else {
                    
                    self.game!.addGameToHistory() { (error) in
                        if let error = error {
                            Service.presentAlert(on: self, title: "Error", message: error)
                        } else {
                        
                            print("\nFinished uploading result\nNow let's save it locally and to our User object\n\nDo not forget to also save the game and the user here\n\n")
                            self.game!.deleteGame(game: self.game!, completion: { (error) in
                                if let error = error {
                                    Service.presentAlert(on: self, title: "Error Deleting Game", message: error)
                                } else {
                                    print("Successfully deleted the game")
                                }
                            })
                        }
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.performSegue(withIdentifier: "toGameOverSegue", sender: nil)
        }
    }
    
    
	
	private func getPlayer1Damage() {
		var player1Damage: CGFloat = 0
		
		
		
		switch player1TagSelected.attack {
		case (14): //p1 Light Up
			ryuImageName = RyuAnimationName.RyuPunchHighLight
			player1Damage = CGFloat(p1Button14LUp.damage) * p1Button14LUp.damageMultiplier
			
			p1Button14LUp.cooldown = 2
			p1MoveResult.speed! += 9
			
		case (15): //p1 Medium Up
            ryuImageName = RyuAnimationName.RyuPunchHighMedium
			player1Damage = CGFloat(p1Button15MUp.damage) * p1Button15MUp.damageMultiplier
			p1Button15MUp.cooldown = 3
			p1MoveResult.speed! += 6
			
		case (16): //p1 Heavy Up
            ryuImageName = RyuAnimationName.RyuPunchHighHard
			player1Damage = CGFloat(p1Button16HUp.damage) * p1Button16HUp.damageMultiplier
			p1Button16HUp.cooldown = 4
			
			p1MoveResult.speed! += 3
			
		case (17): //p1 Light Down
            ryuImageName = RyuAnimationName.RyuPunchLowLight
			player1Damage = CGFloat(p1Button17LDown.damage) * p1Button17LDown.damageMultiplier
			p1Button17LDown.cooldown = 2
			p1MoveResult.speed! += 9
			
			
		case (18): //p1 Medium Down
            ryuImageName = RyuAnimationName.RyuPunchLowMedium
			player1Damage = CGFloat(p1Button18MDown.damage) * p1Button18MDown.damageMultiplier
			
			p1Button18MDown.cooldown = 3
			p1MoveResult.speed! += 6
			
				
		case (19): //p1 Heavy Down
            ryuImageName = RyuAnimationName.RyuPunchLowHard
			player1Damage = CGFloat(p1Button19HDown.damage) * p1Button19HDown.damageMultiplier
			
			p1Button19HDown.cooldown = 4
			p1MoveResult.speed! += 3
			
		case .none, 1:
			player1Damage = 0
            p1MoveResult.speed! = 0
		default:
			break
		}
		
		for button in player1MoveButtons! where button.selectedButton == true { //put p1 move on cooldown
			button.cooldown = 2
		}
		
		p1MoveResult.damage = Int(player1Damage)
//        print("player 1 damage = \(p1MoveResult.damage)")
	}
	

	private func getPlayer2Damage() {
		var player2Damage: CGFloat = 0
		
		switch player2TagSelected.attack {
		case (24): //p2 Heavy Up
            kenImageName = KenAnimationName.KenPunchHighHard
			player2Damage = CGFloat(p2Button24HUp.damage) * p2Button24HUp.damageMultiplier
			p2Button24HUp.cooldown = 4
			p2MoveResult.speed! += 3
			
		case (25): //p2 Medium Up
            kenImageName = KenAnimationName.KenPunchHighMedium
			player2Damage = CGFloat(p2Button25MUp.damage) * p2Button25MUp.damageMultiplier
			p2Button25MUp.cooldown = 3
			p2MoveResult.speed! += 6
			
			
		case (26): //p2 Light Up
            kenImageName = KenAnimationName.KenPunchHighLight
			player2Damage = CGFloat(p2Button26LUp.damage) * p2Button26LUp.damageMultiplier
			p2Button26LUp.cooldown = 2
			p2MoveResult.speed! += 9
			
		case (27): //p2 Heavy Down
            kenImageName = KenAnimationName.KenPunchLowHard
			player2Damage = CGFloat(p2Button27HDown.damage) * p2Button27HDown.damageMultiplier
			p2Button27HDown.cooldown = 4
			p2MoveResult.speed! += 3
			
		case (28): //p2 Medium Down
            kenImageName = KenAnimationName.KenPunchLowMedium
			player2Damage = CGFloat(p2Button28MDown.damage) * p2Button28MDown.damageMultiplier
			p2Button28MDown.cooldown = 3
			p2MoveResult.speed! += 6
			
		case (29): //p2 Light Down
            kenImageName = KenAnimationName.KenPunchLowLight
			player2Damage = CGFloat(p2Button29LDown.damage) * p2Button29LDown.damageMultiplier
			p2Button29LDown.cooldown = 2
			p2MoveResult.speed! += 9
			
		case .none, 1:
			p2MoveResult.speed = 0
			player2Damage = 0
		default:
			break
		}
		
		
		
		
		for button in player2MoveButtons! where button.selectedButton == true { //put p2 move on cooldown
			button.cooldown = 2
		}
		p2MoveResult.damage = Int(player2Damage)
//		p2MoveResult.damage = Int(player2Damage * player1Defense)
//        print("player 2 damage = \(p2MoveResult.damage)")
	}
	
	private func getEnemyDefense() {
	//p1 move tag
		switch player1TagSelected.move {
		case 11: //if p1 moved backward
			p1MoveResult.speed! /= 2
			p1MoveResult.defenseMultiplier! *= 0.75
			
		case 13: //if p1 moved forward, double the attack's speed and slightly increase damage
			p1MoveResult.speed! *= 2
			p1MoveResult.damageMultiplier! *= 1.25
			
		
		case 10: //if p1 jumped
			p1MoveResult.speed! *= 1
			switch player2TagSelected.attack {
			case 24,25,26,.none, 1: //p2 attacked high
				p1MoveResult.defenseMultiplier! *= 1 //if p1 jumped up and p2 attacked up, p1's defense is 1
			case 27,28,29: //p2 attacked low
				p1MoveResult.defenseMultiplier! *= 0 //if p1 jumped up and p2 attacked low, p1's defense is 0
			default:
				break
			}
		case 12: //if p1 crouched
			p1MoveResult.speed! *= 1
			switch player2TagSelected.attack {
			case 24,25,26: //p2 attacked high
				p1MoveResult.defenseMultiplier! *= 0
				
			case 27,28,29,.none, 1: //p2 attacked low
				p1MoveResult.defenseMultiplier! *= 1
				
			default:
				break
			}
		case .none, 1: //if p1 didnt move
			p1MoveResult.speed! *= 1
			p1MoveResult.defenseMultiplier! *= 1
		default:
			break
		}
		
	//p2 move tag
		switch player2TagSelected.move {
		case 21: //if p2 moved forward
			p2MoveResult.speed! *= 2
			p2MoveResult.damageMultiplier! *= 1.25
			
		case 23: //if p2 moved backward
			p2MoveResult.speed! /= 2.0
			p2MoveResult.defenseMultiplier! *= 0.75
		case 20: //if p2 jumped
			p2MoveResult.speed! *= 1
			switch player1TagSelected.attack {
			case 14,15,16,.none, 1: //p1 attacked high
				p2MoveResult.defenseMultiplier! *= 1
				
			case 17,18,19: //p1 attacked low
				p2MoveResult.defenseMultiplier! *= 0
				
			default:
				break
			}
		case 22: //if p2 crouched
			p2MoveResult.speed! *= 1
			switch player1TagSelected.attack {
			case 14,15,16: //p1 attacked high
				p2MoveResult.defenseMultiplier! *= 0
				
			case 17,18,19,.none, 1: //p1 attacked low
				p2MoveResult.defenseMultiplier! *= 1
				
			default:
				break
			}
		case .none, 1: //if p1 didnt move
			p2MoveResult.speed! *= 1
			p2MoveResult.defenseMultiplier! *= 1
		default:
			break
		}
	}
	
	private func setupBackgroundImageView() { //method that will randomly select an image for the background
		let letterArray: [String] = ["A", "B", "C"]
		guard let letter: String = letterArray.randomElement() else { return }
		backgroundName = "background\(letter)"
		switch letter { //depending on the selected letter, apply the max counter
		case "A":
			bgMaxCounter = 11
		case "B":
			bgMaxCounter = 8
		case "C":
			bgMaxCounter = 14
		default:
			break
		}
	}
	
	private func updateViewWithGame(currentGame: Game) {
		DispatchQueue.main.async {
//            self.round?.gameId = currentGame.gameId
//            game?.roundNumber = currentGame.roundNumber
            
			self.gameSessionLabel.text = currentGame.gameId
			
			self.player1ImageView.layer.cornerRadius = 25 //half of the imageView to make it round
			self.player1ImageView.layer.masksToBounds = true
            self.player1ImageView.downloaded(fromLink: "\(currentGame.player1AvatarUrl!)")
//            self.player1ImageView.image = currentGame.player1Image
			
			self.player2ImageView.layer.cornerRadius = 25 //half of the imageView to make it round
			self.player2ImageView.layer.masksToBounds = true
            self.player2ImageView.downloaded(fromLink: "\(currentGame.player2AvatarUrl!)")
//            self.player2ImageView.image = currentGame.player2Image
			
            
			self.player1NameLabel.text = "\(currentGame.player1Name!)"
			self.player1HPLabel.text = "\(currentGame.player1HP)/30"
			
			self.player2NameLabel.text = "\(currentGame.player2Name!)"
			self.player2HPLabel.text = "\(currentGame.player2HP)/30"
			
			
			if currentGame.player1Id == currentGame.player2Id { //if user is playing against itself
				self.player1MovesView.isUserInteractionEnabled = true
				self.player2MovesView.isUserInteractionEnabled = true
				self.isAgainstOnlineUser = false
			} else { //if we have a different opponent
				self.isAgainstOnlineUser = true
				if currentGame.player1Id == User.currentId() {
					self.player1MovesView.isUserInteractionEnabled = true
					self.player2MovesView.isUserInteractionEnabled = false
				} else if currentGame.player2Id == User.currentId() {
					self.player2MovesView.isUserInteractionEnabled = true
					self.player1MovesView.isUserInteractionEnabled = false
				} else {
					print("This is not our game")
				}
			}
		}
	}
	
    
    func updateButtonsAnimations() { //function that will determine button's animation, either smallFire, BigFire, no animation
        for button in self.player1AttackButtons! { //check p1 selected buttons and apply the necessary fire animation
            if button.selectedButton == false { continue }
            switch button {
            case self.p1Button14LUp:
                if button.animation == ButtonAnimations.SmallFire && self.p2MoveResult.defenseMultiplier! != 0 {
                    
                    self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
                    if self.p1Button16HUp.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button16HUp, animation: ButtonAnimations.BigFire)
                    }
                    if self.p1Button19HDown.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button19HDown, animation: ButtonAnimations.BigFire)
                    }
                    
                } else if self.p1Button15MUp.cooldown <= 1 && self.p1Button17LDown.cooldown <= 1 &&
                    self.p2MoveResult.defenseMultiplier! != 0 {
                    if self.p1Button15MUp.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button15MUp, animation: ButtonAnimations.SmallFire)
                    }
                    self.putAnimation(button: self.p1Button17LDown, animation: ButtonAnimations.SmallFire)
                    if self.p1Button18MDown.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button18MDown, animation: ButtonAnimations.BigFire)
                    }
                } else {
                    self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
                    continue
                }
            case self.p1Button15MUp:
                if button.animation == ButtonAnimations.SmallFire && self.p2MoveResult.defenseMultiplier! != 0 {
                    self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
                    if self.p1Button16HUp.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button16HUp, animation: ButtonAnimations.BigFire)
                    }
                    if self.p1Button19HDown.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button19HDown, animation: ButtonAnimations.BigFire)
                    }
                } else if self.p1Button14LUp.cooldown <= 1 && self.p1Button17LDown.cooldown <= 1 && self.p2MoveResult.defenseMultiplier! != 0 {
                    
                    self.putAnimation(button: self.p1Button14LUp, animation: ButtonAnimations.SmallFire)
                    self.putAnimation(button: self.p1Button17LDown, animation: ButtonAnimations.SmallFire)
                    if self.p1Button18MDown.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button18MDown, animation: ButtonAnimations.BigFire)
                    }
                } else {
                    self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
                    continue
                }
            case self.p1Button16HUp:
                self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
            case self.p1Button17LDown:
                if button.animation == ButtonAnimations.SmallFire && self.p2MoveResult.defenseMultiplier! != 0 {
                    self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
                    if self.p1Button16HUp.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button16HUp, animation: ButtonAnimations.BigFire)
                    }
                    if self.p1Button19HDown.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button19HDown, animation: ButtonAnimations.BigFire)
                    }
                } else if self.p1Button15MUp.cooldown <= 1 && self.p1Button14LUp.cooldown <= 1 && self.p2MoveResult.defenseMultiplier! != 0 {
                    if self.p1Button15MUp.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button15MUp, animation: ButtonAnimations.SmallFire)
                    }
                    self.putAnimation(button: self.p1Button14LUp, animation: ButtonAnimations.SmallFire)
                    if self.p1Button18MDown.cooldown <= 1 {
                        self.putAnimation(button: self.p1Button18MDown, animation: ButtonAnimations.BigFire)
                    }
                } else {
                    self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
                    continue
                }
                
            case self.p1Button18MDown:
                self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
            case self.p1Button19HDown:
                self.removeAttackButtonsAnimation(buttons: self.player1AttackButtons!)
            default:
                break
            }
        }
        
        
        for button in self.player2AttackButtons! { //check p2 selected buttons and apply the necessary fire animation
            if button.selectedButton == false { continue }
            
            switch button {
            case self.p2Button26LUp:
                if button.animation == ButtonAnimations.SmallFire && self.p1MoveResult.defenseMultiplier! != 0 {
                    self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
                    
                    if self.p2Button24HUp.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button24HUp, animation: ButtonAnimations.BigFire)
                    }
                    if self.p2Button27HDown.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button27HDown, animation: ButtonAnimations.BigFire)
                    }
                } else if self.p2Button25MUp.cooldown <= 1 && self.p2Button29LDown.cooldown <= 1 && self.p1MoveResult.defenseMultiplier! != 0 {
                    
                    if self.p2Button25MUp.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button25MUp, animation: ButtonAnimations.SmallFire)
                    }
                    self.putAnimation(button: self.p2Button29LDown, animation: ButtonAnimations.SmallFire)
                    if self.p2Button28MDown.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button28MDown, animation: ButtonAnimations.BigFire)
                    }
                } else {
                    self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
                    continue
                }
            case self.p2Button25MUp:
                if button.animation == ButtonAnimations.SmallFire && self.p1MoveResult.defenseMultiplier! != 0 {
                    self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
                    if self.p2Button24HUp.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button24HUp, animation: ButtonAnimations.BigFire)
                    }
                    if self.p2Button27HDown.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button27HDown, animation: ButtonAnimations.BigFire)
                    }
                } else if self.p2Button26LUp.cooldown <= 1 && self.p2Button29LDown.cooldown <= 1 && self.p1MoveResult.defenseMultiplier! != 0 {
                    self.putAnimation(button: self.p2Button26LUp, animation: ButtonAnimations.SmallFire)
                    self.putAnimation(button: self.p2Button29LDown, animation: ButtonAnimations.SmallFire)
                    if self.p2Button28MDown.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button28MDown, animation: ButtonAnimations.BigFire)
                    }
                } else {
                    self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
                    continue
                }
            case self.p2Button24HUp:
                self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
            case self.p2Button29LDown:
                if button.animation == ButtonAnimations.SmallFire && self.p1MoveResult.defenseMultiplier! != 0 {
                    self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
                    if self.p2Button24HUp.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button24HUp, animation: ButtonAnimations.BigFire)
                    }
                    if self.p2Button27HDown.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button27HDown, animation: ButtonAnimations.BigFire)
                    }
                } else if self.p2Button25MUp.cooldown <= 1 && self.p2Button26LUp.cooldown <= 1 && self.p1MoveResult.defenseMultiplier! != 0 {
                    if self.p2Button25MUp.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button25MUp, animation: ButtonAnimations.SmallFire)
                    }
                    self.putAnimation(button: self.p2Button26LUp, animation: ButtonAnimations.SmallFire)
                    if self.p2Button28MDown.cooldown <= 1 {
                        self.putAnimation(button: self.p2Button28MDown, animation: ButtonAnimations.BigFire)
                    }
                } else {
                    self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
                    continue
                }
            case self.p2Button28MDown:
                self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
            case self.p2Button27HDown:
                self.removeAttackButtonsAnimation(buttons: self.player2AttackButtons!)
            default:
                break
            }
        }
    }
    
    
	private func removeAttackButtonsAnimation(buttons: [MovesButton]) {
		for button in buttons where button.animation != ButtonAnimations.None {
			putAnimation(button: button, animation: ButtonAnimations.None)
		}
	}
	
//MARK: Helpers -----------------------------------------------------
	@objc func updateTurnTime() {
		clockCounter -= 1
		timeLeftLabel.text = "\(clockCounter)"
		
		if clockCounter == 0 {
			clockTimer?.invalidate()
            
			setupSelectedTag()
		}
	}
	
    
    private func finishTurn() {
        DispatchQueue.main.async {
            self.updateButtonsAnimations()
        
            
            self.player1TagSelected = (nil, nil)
            self.player2TagSelected = (nil, nil)
            
            guard let allButtons = self.allButtons else { return }
            deselectOtherButtons(buttons: allButtons)
            
            if self.game!.player1Id == self.game!.player2Id { //if user is playing against itself
                self.player1MovesView.isUserInteractionEnabled = true
                self.player2MovesView.isUserInteractionEnabled = true
                self.isAgainstOnlineUser = false
            } else { //if players are 2 different opponent
                self.isAgainstOnlineUser = true
                if self.game!.player1Id == User.currentId() {
                    self.player1MovesView.isUserInteractionEnabled = true
                    self.player2MovesView.isUserInteractionEnabled = false
                } else if self.game!.player2Id == User.currentId() {
                    self.player2MovesView.isUserInteractionEnabled = true
                    self.player1MovesView.isUserInteractionEnabled = false
                } else {
                    print("This is not our game")
                }
            }
            
            for button in allButtons {
                if button.cooldown > 0 {
                    button.cooldown -= 1
                }
            }
            
            updateButtonsView(buttons: allButtons)
            
            self.game?.roundNumber += 1
            
            UserDefaults.standard.set(gameDictionaryFrom(game: self.game!), forKey: self.game!.gameId)
            UserDefaults.standard.synchronize()
            
            self.roundNumberLabel.text = "\(self.game!.roundNumber)"
            self.clockCounter = 8
            self.timeLeftLabel.text = "\(self.clockCounter)"
            
            self.startTurnTimer()
            
        }
    }
	
	@objc func ryuStandingAnimation() { //method that gets run every 0.1 seconds and animates player1Character (ryu) depending on the assigned ryuImageName
        
//        self.player1Character.image = UIImage.animatedImage(with: <#T##[UIImage]#>, duration: <#T##TimeInterval#>)
		self.player1Character.image = UIImage(named: "\(ryuImageName.0)\(ryuCounter)")
		ryuCounter += 1
		if ryuCounter == ryuImageName.1 { //if ryuCounter has reached the image's max amount of frames then set it back to 0
			ryuCounter = 0
			if ryuImageName != RyuAnimationName.Standing { //this ensures any animation is ran once
				ryuImageName = RyuAnimationName.Standing
			}
		}
	}
	
	@objc func kenStandingAnimation() {
		player2Character.image = UIImage(named: "\(kenImageName.0)\(kenCounter)") //p2's image will be whatever kenImageName is assigned as with an incrementing kenCounter
		kenCounter += 1
        if kenCounter == kenImageName.1 { //if kenCounter is = to kenImageName's maxCounter, then go back to 0
            kenCounter = 0
            if kenImageName != KenAnimationName.KenStanding { //once that animation is over, go back to standing animation
                kenImageName = KenAnimationName.KenStanding
            }
        }
	}
	
	@objc func backgroundAnimation() {
		backgroundImageView.image = UIImage(named: "\(backgroundName)\(backgroundCounter)")
		backgroundCounter += 1
		if backgroundCounter == bgMaxCounter { backgroundCounter = 0 }
		
	}
	
	
//MARK: IBActions -----------------------------------------------------
	@IBAction func player2MoveButtonTapped(_ sender: MovesButton) {
		deselectOtherButtons(buttons: player2MoveButtons!)
		if isAgainstOnlineUser{
			selectMoveButton(button: sender) //selectedButton = true AND add red border color
		} else { sender.selectedButton = true }
		player2TagSelected.move = sender.buttonTag
	}
	
	@IBAction func player2AttackButtonTapped(_ sender: MovesButton) {
		deselectOtherButtons(buttons: player2AttackButtons!)
		if isAgainstOnlineUser{
			selectMoveButton(button: sender) //selectedButton = true AND add red border color
		} else { sender.selectedButton = true }
		player2TagSelected.attack = sender.buttonTag
	}
	
	@IBAction func moveButtonTapped(_ sender: MovesButton) {
		deselectOtherButtons(buttons: player1MoveButtons!)
		if isAgainstOnlineUser{
			selectMoveButton(button: sender) //selectedButton = true AND add red border color
		} else { sender.selectedButton = true }
		player1TagSelected.move = sender.buttonTag
	}
	
	@IBAction func attackButtonTapped(_ sender: MovesButton) {
		deselectOtherButtons(buttons: player1AttackButtons!)
		if isAgainstOnlineUser{
			selectMoveButton(button: sender) //selectedButton = true AND add red border color
		} else { sender.selectedButton = true }
		player1TagSelected.attack = sender.buttonTag
	}
	
	
	
}

