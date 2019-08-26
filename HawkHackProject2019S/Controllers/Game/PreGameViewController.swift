//
//  PreGameViewController.swift
//  HawkHackProject2019S
//
//  Created by Samuel Folledo on 3/30/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol MatchesTableViewCellDelegate {
	func segueWithGameUid(withGame game: Game)
	func removeGame(withGame game: Game, indexPath: IndexPath)
}

class PreGameViewController: UIViewController {
	
	//MARK: IBOutlets
	@IBOutlet weak var helloLabel: UILabel!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var topButton: UIButton! //invite other players button
    @IBOutlet weak var matchHistoryButton: UIButton!
    @IBOutlet weak var matchesTableView: UITableView!
    
    
	//MARK: Properties
	var game = Game.sharedInstance
	var users = [User]()
	
	var opponentUID: String?
	var gameSessionID: String?
	
	var matches = [Game]()
	
	
	//MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss(tap:)))
		self.view.addGestureRecognizer(tap)
		
		matchesTableView.register(UINib(nibName: "MatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "matchesCell")
		matchesTableView.delegate = self
		matchesTableView.dataSource = self
		matchesTableView.tableFooterView = UIView(frame: .zero)
		
		fetchUsers()
		
        disableView(view: topButton)
		
		if isUserLoggedIn() {
			incomingRequest()
		}
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if User.currentUser() == nil {
			helloLabel.text = "Please login or register in order to play a game"
            disableView(view: topButton)
            disableView(view: matchHistoryButton)
            disableView(view: emailTextField)
		} else {
			helloLabel.text = "Hello \(User.currentUser()!.name). Enter the email you would like to play against and click the invite button."
            enableView(view: topButton)
            enableView(view: matchHistoryButton)
            enableView(view: emailTextField)
            incomingRequest()
		}
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case "preGameToGameSegue":
			guard let game: Game = sender as? Game else { return }
            
            let gameVC: CurrentGameViewController = segue.destination as! CurrentGameViewController
            print(gameDictionaryFrom(game: game))
            gameVC.game = game
        
//            //            print("game uid to segue is \(game.gameId)")
////            let game2 = UserDefaults.standard.dictionary(forKey: game.gameId)
//            if let gameDictionary = UserDefaults.standard.object(forKey: game.gameId) { //if game was saved before
//                print("Game has been played before = \(gameDictionary)")
//                let currentGame: Game = Game.init(_dictionary: gameDictionary as! [String : Any])
//
//                let gameVC: CurrentGameViewController = segue.destination as! CurrentGameViewController
//                gameVC.game = currentGame
//
//            } else { //if game was never saved, start it
//
//                let gameVC: CurrentGameViewController = segue.destination as! CurrentGameViewController
//                gameVC.game = game
//
//                UserDefaults.standard.set(game, forKey: game.gameId)
//                UserDefaults.standard.synchronize()
//            }
        default:
            break
        }
	}
	
	
	
	//MARK: IBActions
	@IBAction func topButtonTapped(_ sender: Any) {
		sendRequest()
	}
	
	
	//MARK: Methods for sending requests
	func sendRequest() {
		let userId = User.currentId()
        emailTextField.resignFirstResponder()
        
		guard let opponentEmail = self.emailTextField.text?.trimmedString() else { return }
		
		if opponentEmail.isValidEmail && opponentEmail != "" {
			var opponentUid: String = ""
			for user in users { //go through each users and find email that matches our textfield
				if user.email == opponentEmail {
					opponentUid = user.userID //this givesUID us the user that matches with the email we typed
					break
				} else { continue }
			}
//            print("OpponentUid = \(opponentUid)")
			if opponentUid == "" { return }
			
			fetchOpponentUserWith(opponentUid: opponentUid) { (opponentUser) in
				guard let opponentUser = opponentUser else { return }
				
				DispatchQueue.main.async { //is needed or it will create 2 requests
					let opponentDic = opponentUserToDictionaryFrom(user: opponentUser)
//                    print("OpponentDic is \(opponentDic)")
					//					print("OPPONENTDIC FROM SEND REQUEST IS \(opponentDic)")
					guard let user = User.currentUser() else { return }
					var gameValues: [String: AnyObject] = [kPLAYER1ID : userId, kPLAYER1EMAIL: user.email, kPLAYER1NAME: user.name, kPLAYER1AVATARURL: user.avatarURL, kPLAYER1HP: 30, kPLAYER2HP: 30 ] as [String: AnyObject] //values of our currentUser
					
					opponentDic.forEach {gameValues[$0] = $1} //combine each element in opponentDic to our values before we send the request
					
					self.sendRequestWithProperties(gameValues, to: opponentUid)
				}
				
			}
		}
	}
	
	func sendRequestWithProperties(_ properties: [String: AnyObject], to opponentUid: String) {
		//start game session reference with properties/values
		let ref = firDatabase.child(kGAMESESSIONS)
		let gameReference = ref.childByAutoId()
		guard let gameId: String = gameReference.key else { return }
		let timeStamp: Int = Int(Date().timeIntervalSince1970)
		
		
        var gameValues: [String: AnyObject] = [kCREATEDAT: timeStamp, kUPDATEDAT: timeStamp, kGAMEID: gameId] as [String: AnyObject] //values for our game session on top of each users's infos
        
		properties.forEach {gameValues[$0] = $1}
//        print("Game values is created. Recommended to also save this in Core Data \(gameValues)")
        
        
        
        
        
		gameReference.updateChildValues(gameValues) { (error, ref) in //update our values in our reference
			if let error = error {
				Service.presentAlert(on: self, title: "Error", message: error.localizedDescription); return
			} else {
				
//after updating our GAMESESSION's values, we will now create a reference to GAMESESSION's ids for our user's USERTOGAMESESSIONS
				guard let user = User.currentUser() else { return }
				let currentUserGameRef = firDatabase.child(kUSERTOGAMESESSIONS).child(user.userID).child(opponentUid)
				
				currentUserGameRef.updateChildValues([gameId: 1], withCompletionBlock: { (error, ref) in
					if let error = error {
						Service.presentAlert(on: self, title: "Firebase Error", message: error.localizedDescription); return
					} else {
						
						let opponentUserGameRef = firDatabase.child(kUSERTOGAMESESSIONS).child(opponentUid).child(user.userID)
						opponentUserGameRef.updateChildValues([gameId: 1], withCompletionBlock: { (error, ref) in
							if let error = error  {
								Service.presentAlert(on: self, title: "Error", message: error.localizedDescription); return
							} else {
								print("Creating opponent user's game reference was successful")
								
							}
						})
					}
				})
                
//                UserDefaults.standard.set(gameValues, forKey: gameId)
//                UserDefaults.standard.synchronize()
//                
			}
		}
	}
	
	
	
	
	//MARK: Methods for incoming Requests
	func incomingRequest() {
		//		var properties: [String: AnyObject]?
		let requestReference = firDatabase.child(kUSERTOGAMESESSIONS).child(User.currentId()) //MISSING OPPONENT'S UID before we can access the game session id
		requestReference.observe(.value, with: { (snapshot) in
			
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { print("No requests found"); return }
//            guard let snapshot = snapshot.value as? NSDictionary else { print("no requests found"); return }
//            print(snapshot)
			for snap in snapshot { //each snap in snapshot is a dictionary //snap.key is the opponentUID and snap.value is the gameSessionId : 1
				guard let gameSessionUids = snap.value as? [String: AnyObject] else { print("snap.value cannot be found"); return } //snap.value = gameSessionId : 1 //has to be converted to [String: AnyObject] in order to get the snap.value properly
				self.gameUidsToGame(gameUidDictionary: gameSessionUids)
				
				
			}
		}, withCancel: nil)
	}
	
	func gameUidsToGame(gameUidDictionary: [String: AnyObject]) {
		//		print("\n\n\nKeys are\(gameUidDictionary.keys)\nValues are\(gameUidDictionary.values)\n\n\n")
        self.matches.removeAll()
		for key in gameUidDictionary.keys {
			
			fetchGameWith(gameSessionId: key, completion: { (game) in
				DispatchQueue.main.async {
//                    self.matches.removeAll()
                    
					guard let game = game else { return }
                    
                    print("Fetched game found = \(game)")
					
					self.matches.append(game)
					self.matchesTableView.reloadData()
				}
			})
		}
		
	}
	
	
//MARK: Helper private methods
	private func fetchUsers() {
		let ref = firDatabase.child(kUSERS)
		ref.observe(.childAdded, with: { (snapshot) in
//            print("user found and snapshot is \(snapshot)")
			guard let userDic = snapshot.value as? [String: Any] else { return }
            guard let pushId: String = userDic[kPUSHID] as? String else { print("No pushId"); return }
            guard let name: String = userDic[kNAME] as? String else { print("No name"); return }
            guard let email: String = userDic[kEMAIL] as? String else { print("No email"); return }
            guard let avatarUrl: String = userDic[kAVATARURL] as? String else { print("No avatarUrl"); return }
            guard let wins: Int = userDic[kWINS] as? Int else { print("No wins"); return }
            guard let loses: Int = userDic[kLOSES] as? Int else { print("No loses"); return }
            guard let experience: Int = userDic[kEXPERIENCES] as? Int else { print("No experience"); return }
            guard let level: Int = userDic[kLEVEL] as? Int else { print("No level"); return }
//            guard let pushId: String = userDic[kPUSHID] as? String else { print("No pushId"); return }
//            print(snapshot.key)
//            print("snapshot.value is \(userDic)")
//            User(_u)
//            let user = User(_userID: snapshot.key, _pushId: userDic[kPUSHID] as! String, _name: userDic[kNAME]! as! String, _email: userDic[kEMAIL]! as! String, _experience: userDic[kEXPERIENCES]! as! Int, _level: userDic[kLEVEL]! as! Int)
            let user = User(_userID: snapshot.key, _pushId: pushId, _name: name, _email: email, _avatarURL: avatarUrl, _wins: wins, _loses: loses, _experience: experience, _level: level)
            
            print("You can save other users here in Core Data")
            
//            let user = User(_dictionary: userDic)
//            user.name = userDic[kNAME]!
//            user.email = userDic[kEMAIL]!
//            user.userID = snapshot.key
			
			self.users.append(user)
		}, withCancel: nil)
//        print("Users \(users)")
	}
	
	@objc func tapToDismiss(tap: UITapGestureRecognizer) {
		self.view.endEditing(true)
	}
	
	private func disableView(view: UIView) {
		view.alpha = 0.2
		view.isUserInteractionEnabled = false
	}
	private func enableView(view: UIView) {
		view.alpha = 1
		view.isUserInteractionEnabled = true
	}
	
	
	
	
	
	
}



extension PreGameViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return matches.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		tableView.rowHeight = 70 //PB ep78 22mins assign the height same as what we have in the xib
		let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell", for: indexPath) as! MatchesTableViewCell //PB ep78 23-24mins after we get the item, initiate our cell
		
		let match = matches[indexPath.row]
		cell.indexPath = indexPath
		cell.setCellData(game: match)
		cell.delegate = self
        
		return cell
	}
	
}

//MatchesTableViewCellDelegate Methods
extension PreGameViewController: MatchesTableViewCellDelegate {
    func segueWithGameUid(withGame game: Game) {
        
        if let gameDictionary = UserDefaults.standard.object(forKey: game.gameId) as? [String: Any] { //if game was saved before
            print("Game has been played before = \(gameDictionary)")
            let currentGame: Game = Game.init(_dictionary: gameDictionary)
            self.performSegue(withIdentifier: "preGameToGameSegue", sender: currentGame)
            
        } else { //if game was never saved, start it, sender: game)
            
//            let gameVC: CurrentGameViewController = segue.destination as! CurrentGameViewController
//            gameVC.game = game
            print("Game has never been started in this device \(game)")
            UserDefaults.standard.set(gameDictionaryFrom(game: game), forKey: game.gameId)
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "preGameToGameSegue", sender: game)
        }
        
        
        
//        self.performSegue(withIdentifier: "preGameToGameSegue", sender: game)
    }
    
	func removeGame(withGame game: Game, indexPath: IndexPath) {
		game.deleteGame(game: game) { (error) in
			if let error = error {
                Service.presentAlert(on: self, title: "Error Removing Game", message: error)
			} else {
				self.matches.remove(at: indexPath.row)
				self.matchesTableView.reloadData()
			 }
		}
	}
}
