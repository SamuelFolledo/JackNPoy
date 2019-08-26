//
//  Game.swift
//  HawkHackProject2019S
//
//  Created by Samuel Folledo on 3/30/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import Foundation
import FirebaseAuth

class Game {
	
	
	var player1Id: String?
	var text: String?
	var player2Id: String?
	var gameId: String = ""
	
	var winnerUid: String?
//    var timeStamp: Int?
	var player1HP: Int = 30
	var player2HP: Int = 30
	
	var player1Name: String?
	var player2Name: String?
//    var player1Email: String?
//    var player2Email: String?
	
	var player1AvatarUrl: String?
	var player2AvatarUrl: String?
    
    var player1Image: UIImage?
    var player2Image: UIImage?
    
    var roundNumber = 0
	
//    var createdAt: Date?
//    var updatedAt: Date?
    var createdAt: Int?
    var updatedAt: Int?
	
	static let sharedInstance = Game() //initialize this Game as singleton
	private init() {} //PB ep75 2mins this prevents reinitialization. This prevents us to invoke the ShoppingCart.init(), the access of this class is only through sharedInstance
	
	init(_dictionary: [String: Any]) { //constructor
		self.player1Id = _dictionary[kPLAYER1ID] as? String
		self.text = _dictionary["text"] as? String
		self.player2Id = _dictionary[kPLAYER2ID] as? String
		self.gameId = _dictionary[kGAMEID] as! String
		
		self.winnerUid = _dictionary[kWINNERUID] as? String
//        self.timeStamp = _dictionary[kTIMESTAMP] as? Int
		self.player1HP = _dictionary[kPLAYER1HP] as! Int
		self.player2HP = _dictionary[kPLAYER2HP] as! Int
		
		self.player1Name = _dictionary[kPLAYER1NAME] as? String
		self.player2Name = _dictionary[kPLAYER2NAME] as? String
		
//        self.player1Email = _dictionary[kPLAYER1EMAIL] as? String
//        self.player2Email = _dictionary[kPLAYER2EMAIL] as? String
		self.player1AvatarUrl = _dictionary[kPLAYER1AVATARURL] as? String
		self.player2AvatarUrl = _dictionary[kPLAYER2AVATARURL] as? String
        
//        self.createdAt = dateFormatter().date(from: _dictionary[kCREATEDAT] as! String)!
//        self.updatedAt = dateFormatter().date(from: _dictionary[kUPDATEDAT] as! String)!
        self.createdAt = _dictionary[kCREATEDAT] as? Int
        self.updatedAt = _dictionary[kUPDATEDAT] as? Int
        
        
	}
	
    
    deinit {
//        print("Game \(self.gameId) is being deinitialized")
    }
    
//    class func currentGame(game: Game) -> Game? {
//        if Auth.auth().currentUser != nil { //if we have user...
//            if let dictionary = UserDefaults.standard.object(forKey: kCURRENTUSER) {
//                return User.init(_dictionary: dictionary as! [String: Any])
//            }
//        }
//        return nil //if we dont have user in our UserDefaults, then return nil
//    }
	
	internal func gamePartnerId() -> String {
		return (player1Id == User.currentId() ? player2Id : player1Id)!
	}
	
    func addGameToHistory(game: Game, completion: @escaping (_ value: String?)-> Void) {
    //lastly, add it to GameHistory
        let userGameHistoryRef = firDatabase.child(kGAMEHISTORY).child(User.currentId()).child(game.gameId)
        userGameHistoryRef.setValue(gameDictionaryFrom(game: game)) { (error, ref) in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                print("succesfully saved the game in kGAMEHISTORY")
                completion(nil)
            }
        }
        
    }
    
	func deleteGame(game: Game, completion: @escaping (_ value: String?)-> Void) {
		let player1Ref = firDatabase.child(kUSERTOGAMESESSIONS).child(game.player1Id!).child(game.player2Id!)
		player1Ref.removeValue { (error, ref) in
			if let error = error {
				completion(error.localizedDescription)
			} else {
				print("Successfully removed \(game.gameId) from P1")
//				completion("Success")
			}
		}
		
		let player2Ref = firDatabase.child(kUSERTOGAMESESSIONS).child(game.player2Id!).child(player1Id!)
		player2Ref.removeValue { (error, ref) in
			if let error = error {
				completion(error.localizedDescription)
			} else {
				print("Successfully removed \(game.gameId) from P2")
//				completion("Success")
			}
		}
		
    //now remove it from gameSessions
		let userToGameRef = firDatabase.child(kGAMESESSIONS).child(game.gameId)
		userToGameRef.removeValue { (error, ref) in
			if let error = error {
				completion(error.localizedDescription)
			} else {
				print("Successfully removed \(game.gameId) from userToGame reference")
//				completion("Success")
			}
		}
        
    
        
        completion(nil)
	}
	
	internal func reset() {
		self.player2Id = nil
		self.player1Id = nil
		self.text = nil
		self.gameId = ""
		
		self.winnerUid = nil
//        self.timeStamp = nil
		self.player1HP = 100
		self.player2HP = 100
		
		self.player1Name = ""
		self.player2Name = ""
//        self.player1Email = ""
//        self.player2Email = ""
	}
    
    
                        //------UPLOAD GAME RESULT------
    func saveGameResult(game: Game, completion: @escaping (_ error: String?)-> Void) {
        print("uploadGameResult is now being ran")
        
//        UserDefaults.standard.set(gameDictionaryFrom(game: game), forKey: game.gameId)
//        UserDefaults.standard.synchronize()
        
        //MARK: These next26 lines basically upload current user's result of the game
        let user: User = User.currentUser()!
        
//        print("\n\n\nUser dictionary of the user uploading gamae result = \(userDictionaryFrom(user: user))")
        
        let userUid = user.userID
    
        
        
        
        
        let userRef = firDatabase.child(kUSERS).child(userUid).child(kGAMESTATS)//NOW WORK ON PULLING WINNER/LOSER, EXPERIENCE, AND LEVEL
        print("save the game result from here")
        
//save in User Entity
        userRef.observeSingleEvent(of: .value, with: { (snap) in
            if let userDic = snap.value as? NSDictionary {
                //                print("User dic in uploadGameResult = \(userDic)")
                let wins = userDic[kWINS] as? Int ?? 0
                let loses = userDic[kLOSES] as? Int ?? 0
//                let experience = userDic[kEXPERIENCES] as? Int ?? 0
                
            //update user
                user.wins = userUid == game.winnerUid ? wins + 1 : wins + 0
                user.loses = userUid == game.winnerUid ? loses + 0 : loses + 1
                let expGained = userUid == game.winnerUid ? 100 : 10
                
                increaseExperience(user: user, gained: expGained, completion: {
                    let statsValues: [String: Int] = [kWINS: user.wins!, kLOSES: user.loses!, kEXPERIENCES: user.experience, kLEVEL: user.level]
                    
                    updateCurrentUser(withValues: statsValues, withBlock: { (hasError) in //updateCurrent User first with statsValues then update the userRef
                        if !hasError {//if has error == false
                            completion("Error updating current user")
                        } else {
                            print("No error updating current user's statsValue")
                        }
                    })
                    
                    userRef.updateChildValues(statsValues, withCompletionBlock: { (error, ref) in //n in //LOOKING FOR KEXPERIENCE
                        if let error = error {
                            completion(error.localizedDescription)
                        } else {
                            print("Successfully updated wins stats and experience in firebase")
                        }
                    })
                })
                
            } else { //if there is no snap.value
                
                user.wins = userUid == game.winnerUid ? 1 : 0
                user.loses = userUid == game.winnerUid ? 0 : 1
                let expGained = userUid == game.winnerUid ? 100 : 10
                increaseExperience(user: user, gained: expGained, completion: {
                    let statsValues: [String: Int] = [kWINS: user.wins!, kLOSES: user.loses!, kEXPERIENCES: user.experience, kLEVEL: user.level] //if currentUser won, then increase win by 1 and exp by 100 || lose by 1 and exp by 10
                    
                    updateCurrentUser(withValues: statsValues, withBlock: { (hasError) in //updateCurrent User first with statsValues then update the userRef
                        if !hasError {//if has error == false
                            completion("Error updating current user")
                        } else {
                            print("No error updating current user's statsValue")
                        }
                    })
                    
                    userRef.updateChildValues(statsValues, withCompletionBlock: { (error, ref) in //LOOKING FOR KEXPERIENCE
                        if let error = error {
                            completion(error.localizedDescription)
                        } else {
                            print("Successfully updated wins stats and experience in firebase")
                        }
                    })
                })
            }
        })
        
        
        
//save in GameHistory Entity
//        let opponentUid: String = (game.player1Id == userUid ? game.player2Id : game.player1Id)!
        var opponentUid: String = ""
        var opponentName: String = ""
        var opponentAvatarUrl: String = ""
        var hpLeft = 0
        
        
        if game.player1Id != userUid { //if current user is not player 1, then theyre p2
            opponentUid = (game.player1Id)!
            opponentName = (game.player1Name)!
            opponentAvatarUrl = (game.player1AvatarUrl)!
            hpLeft = (game.player2HP)
        } else {
            opponentUid = (game.player2Id)!
            opponentName = (game.player2Name)!
            opponentAvatarUrl = (game.player2AvatarUrl)!
            hpLeft = (game.player1HP)
        }
        
        
//DISABLED FOR NOW
        let gameHistoryRef = firDatabase.child(kGAMEHISTORY).child(userUid).child(game.gameId)
        let resultValues: [String: Any] = userUid == game.winnerUid ? [kRESULT: "W", kOPPONENTUID: opponentUid, kOPPONENTNAME: opponentName, kOPPONENTAVATARTURL: opponentAvatarUrl, kHPLEFT: hpLeft] : [kRESULT: "L", kOPPONENTUID: opponentUid, kOPPONENTNAME: opponentName, kOPPONENTAVATARTURL: opponentAvatarUrl, kHPLEFT: hpLeft, kGAMEID: game.gameId]
        
        var gameValues = gameDictionaryFrom(game: game) as! Dictionary<String, Any>
        resultValues.forEach {gameValues[$0] = $1}
        
        print("Result is \(resultValues)")
    //save it offline
        UserDefaults.standard.set(resultValues, forKey: game.gameId) //values needs lesser key-value pairs to store
        UserDefaults.standard.synchronize()
        
    //save it online - setting the value in the reference
//        gameHistoryRef.setValue(resultValues) { (error, ref) in //update game history reference
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                print("Finished saving the game in Game History")
//                //                completion(nil)
//            }
//        }
        
        
        print("No error at all!!!")
        completion(nil)
        //
        //    if userUid == game.winnerUid { //if currentUser won... //work on values being set, and maybe return User upon completion()
        //        //set the result in gameHistory
        //        gameHistoryRef.setValue([kRESULT: "W", kOPPONENTUID: opponentUid]) { (error, ref) in
        //            if let error = error {
        //                completion(error.localizedDescription)
        //            } else {
        //                print("Finished saving the win")
        ////                completion(nil)
        //            }
        //        }
        //
        //
        ////grab the user's win, exp, level and update it
        //        userRef.observeSingleEvent(of: .value, with: { (snap) in
        //
        ////            if snap.exists() {
        ////            print("\n\ngame result Snap is \(snap)\n\n")
        ////                guard let userDic = snap.value as? NSDictionary else { print("No userDic found")
        //
        //            if let userDic = snap.value as? NSDictionary {
        ////                print("User dic in uploadGameResult = \(userDic)")
        //                let wins = userDic[kWINS] as? Int ?? 0
        //                let experience = userDic[kEXPERIENCES] as? Int ?? 0
        //
        //                userRef.updateChildValues([kWINS: wins + 1, kEXPERIENCES: experience + 100], withCompletionBlock: { (error, ref) in //LOOKING FOR KEXPERIENCE
        //                    if let error = error {
        //                        completion(error.localizedDescription)
        //                    } else {
        //                        print("Successfully updated wins stats and experience in firebase")
        //                    }
        //                })
        //            } else {
        //                userRef.setValue([kWINS: 1, kEXPERIENCES: 100], withCompletionBlock: { (error, ref) in
        //                    print("This is first game ever, should only be printed once")
        //
        //                    if let error = error {
        //                        completion(error.localizedDescription)
        //
        //                    } else {
        //                        print("First game completed with a win!")
        //
        //                    }
        //                })
        //            }
        //        }, withCancel: nil)
        //
        //    } else { //if userUid != game.winnerUid, meaning currentUser lose
        //        print("current user lost")
        //        gameHistoryRef.setValue(["result": "loser", "opponentUid": opponentUid]) { (error, ref) in
        //            if let error = error {
        //                completion(error.localizedDescription)
        //            } else {
        //                print("Finished saving the lose)")
        //                ////                completion(nil)
        //                //            }
        //                //        }
        //                //
        //            } //end of no error on setting value on gameHistory
        //        } //end of gameHistory.setValue
        //
        //        //        //grab the user's lose, exp, level and update it
        //        userRef.observeSingleEvent(of: .value, with: { (snap) in
        //            //            if snap.exists() {
        //            //                guard let userDic = snap.value as? NSDictionary else { print("No userDic found"); return }
        //            if let userDic = snap.value as? NSDictionary {
        //                let loses = userDic[kLOSES] as? Int ?? 0
        //                let experience = userDic[kEXPERIENCES] as? Int ?? 0
        //
        //                userRef.updateChildValues([kLOSES: loses + 1, kEXPERIENCES: experience + 10], withCompletionBlock: { (error, ref) in
        //                    if let error = error {
        //                        completion(error.localizedDescription)
        //                    } else {
        //                        print("Successfully updated lose stats and experience in firebase")
        //                    }
        //                })
        //
        //            } else {
        //                userRef.setValue([kLOSES: 1, kEXPERIENCES: 10], withCompletionBlock: { (error, ref) in
        //                    print("This is first game ever, should only be printed once")
        //
        //                    if let error = error {
        //                        completion(error.localizedDescription)
        ////                        return
        //                    } else {
        //                        print("First game completed with a LOSE!")
        //
        //                    }
        //                })
        //            } //end of user's 1st fighting game ever
        //        }, withCancel: nil) //end of userRef.observeSingleEvent
        //
        //    } //end of if currentUser lose
        //
    }

//--------------------------------------+++++++++++++++++++++++++++++++++++
    
//    class func currentGameRoundNumber(game: Game) {
//        let ref = firDatabase.child(kGAMESESSIONS).child(game.gameId).child(kTURNCOUNT)
//        ref.observeSingleValue
//    }
    
}

//+++++++++++++++++++++++++   MARK: Saving user   ++++++++++++++++++++++++++++++++++
//func saveGameInBackground(game: Game) {
//
//    let ref = firDatabase.child(kGAMESESSIONS).child(game.gameId)
//
//    let ref = firDatabase.child(kUSERS).child(user.userID)
//    ref.setValue(userDictionaryFrom(user: user))
//    print("Finished saving user \(user.name) in Firebase")
//}

//save locally
//func saveUserLocally(user: User) {
//    UserDefaults.standard.set(userDictionaryFrom(user: user), forKey: kCURRENTUSER)
//    UserDefaults.standard.synchronize()
//    print("Finished saving user \(user.name) locally...")
//}





//MARK: Helper fuctions
//func fetchUserWith(userId: String, completion: @escaping (_ user: User?) -> Void) {
//    //    print("1")
//    //    let ref = firDatabase.child(kGAMESESSIONS).queryEqual(toValue: gameSessionId)
//    let ref = firDatabase.child(kUSERS).child(kUSERID)
//    //    print("2")
//    ref.observeSingleEvent(of: .value, with: { (snapshot) in
//
//        //        print("3")
//        //        print("EYO SNAPSHot\(snapshot)")
//        if snapshot.exists() {
//            print("SNAPSHOT FROM FETCH USERWITH IS \(snapshot)")
//            //            let userDictionary = ((snapshot.value as! NSDictionary).allValues as NSArray).firstObject! as! [String: AnyObject]
//            let userDictionary = snapshot.value as! [String: AnyObject]
//            let user = User(_dictionary: userDictionary)
//            print("FETCHED USER IS \(user)")
//            completion(user)
//        } else { completion(nil) }
//
//
//    }, withCancel: nil)
//    //    ref.observeSingleEvent(of: .value, with: { (snapshot) in
//    //
//    //    }, withCancel: nil)
//}
//func fetchUserWith(userId: String, completion: @escaping (_ user: User?) -> Void) {
//    let ref = firDatabase.child(kUSERS).queryOrdered(byChild: kUSERID).queryEqual(toValue: userId)
//
//    ref.observeSingleEvent(of: .value, with: { (snapshot) in
//        print("SNAPSHOT FROM FETCH USER IS \(snapshot)")
//        if snapshot.exists() {
//            let userDictionary = ((snapshot.value as! NSDictionary).allValues as NSArray).firstObject! as! [String: Any]
//            let user = User(_dictionary: userDictionary)
//            completion(user)
//        } else { completion(nil) }
//    }, withCancel: nil)
//}


//func userDictionaryFrom(user: User) -> NSDictionary { //take a user and return an NSDictionary
//
//    return NSDictionary(
//        objects: [user.userID, user.name, user.email, user.avatarURL],
//        forKeys: [kUSERID as NSCopying, kNAME as NSCopying, kEMAIL as NSCopying, kAVATARURL as NSCopying]) //this func create and return an NSDictionary
//}


//func updateCurrentUser(withValues: [String : Any], withBlock: @escaping(_ success: Bool) -> Void) {
//
//    if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil {
//        guard let currentUser = User.currentUser() else { return }
//        let userObject = userDictionaryFrom(user: currentUser).mutableCopy() as! NSMutableDictionary
//        userObject.setValuesForKeys(withValues)
//
//        let ref = firDatabase.child(kUSERS).child(currentUser.userID)
//        ref.updateChildValues(withValues) { (error, ref) in
//            if error != nil {
//                withBlock(false)
//                return
//            }
//
//            UserDefaults.standard.set(userObject, forKey: kCURRENTUSER)
//            UserDefaults.standard.synchronize()
//            withBlock(true)
//        }
//    }
//
//}

//func isUserLoggedIn() -> Bool {
//    if User.currentUser() != nil {
//        return true
//    } else {
//        return false
//    }
//}

//---------------------------------++++++++++++++++++++++++++++++++++++++++++++++++
func updateCurrentGame(game: Game, withValues: [String : Any], withBlock: @escaping(_ error: String?) -> Void) { //OneSignal S3 ep. 24 withBlock makes it run in the background
    
    //    if UserDefaults.standard.object(forKey: game.gameId) != nil { //check if we have the gameId saved already
    
    guard let gameObject = gameDictionaryFrom(game: game).mutableCopy() as? NSMutableDictionary else {
        print("No gameObject found!!")
        //            withBlock("No game object found")
        return
    }
    gameObject.setValuesForKeys(withValues)
    print("Game object from updateCurrentGame is \(gameObject)")
    
    let ref = firDatabase.child(kGAMESESSIONS).child(game.gameId).child(kCURRENTGAME)
    
    ref.updateChildValues(withValues) { (error, ref) in
        if let error = error {
            withBlock(error.localizedDescription)
        } else {
            UserDefaults.standard.set(gameObject, forKey: game.gameId)
            UserDefaults.standard.synchronize()
            withBlock(nil)
        }
    }
    //    } else { //if we dont have game saved, then create the game
    //        withBlock(nil)
    //    }
}
//MARK: Helper fuctions
//class func uploadGameResult(game: Game, completion: @escaping (_ error: String?)-> Void) {
//    print("uploadGameResult is now being ran")
//    //    func uploadGameResult(completion: @escaping (_ value: String?)-> Void) {
//    //        let loserPlayerUid: String = (player1Id == winningPlayerId ? player2Id : player1Id)! //if winning playerUID is == p1UID then p2 is loser
//
//    //MARK: These next26 lines basically upload current user's result of the game
//    let userUid = User.currentId()
//    let opponentUid: String = (game.player1Id == userUid ? game.player2Id : game.player1Id)!
//
//    let gameHistoryRef = firDatabase.child(kGAMEHISTORY).child(userUid).child(game.gameId)
//    let userRef = firDatabase.child(kUSERS).child(userUid).child(kGAMESTATS)//NOW WORK ON PULLING WINNER/LOSER, EXPERIENCE, AND LEVEL
//
//    let values: [String: String] = userUid == game.winnerUid ? [kRESULT: "W", kOPPONENTUID: opponentUid] : [kRESULT: "L", kOPPONENTUID: opponentUid]
//    gameHistoryRef.setValue(values) { (error, ref) in
//        if let error = error {
//            completion(error.localizedDescription)
//        } else {
//            print("Finished saving the game in Game History")
//            //                completion(nil)
//        }
//    }
//
//
//    userRef.observeSingleEvent(of: .value, with: { (snap) in
//        if let userDic = snap.value as? NSDictionary {
////                print("User dic in uploadGameResult = \(userDic)")
//            let wins = userDic[kWINS] as? Int ?? 0
//            let loss = userDic[kLOSES] as? Int ?? 0
//            let experience = userDic[kEXPERIENCES] as? Int ?? 0
//
//            let statsValues: [String: Int] = userUid == game.winnerUid ? [kWINS: wins + 1, kLOSES: loss, kEXPERIENCES: experience + 100] : [kWINS: wins, kLOSES: loss + 1, kEXPERIENCES: experience + 10] //if currentUser won, then increase win by 1 and exp by 100 || lose by 1 and exp by 10
//
//            userRef.updateChildValues(statsValues, withCompletionBlock: { (error, ref) in //LOOKING FOR KEXPERIENCE
//                if let error = error {
//                    completion(error.localizedDescription)
//                } else {
//                    print("Successfully updated wins stats and experience in firebase")
//                }
//            })
//
//
//        } else { //if there is no snap.value
//            let statsValues: [String: Int] = userUid == game.winnerUid ? [kWINS: 1, kLOSES: 0, kEXPERIENCES: 100] : [kWINS: 0, kLOSES: 1, kEXPERIENCES: 10] //if currentUser won, then increase win by 1 and exp by 100 || lose by 1 and exp by 10
//
//            userRef.updateChildValues(statsValues, withCompletionBlock: { (error, ref) in //LOOKING FOR KEXPERIENCE
//                if let error = error {
//                    completion(error.localizedDescription)
//                } else {
//                    print("Successfully updated wins stats and experience in firebase")
//                }
//            })
//        }
//    })
//
//    print("No error at all!!!")
//    completion(nil)
////
////    if userUid == game.winnerUid { //if currentUser won... //work on values being set, and maybe return User upon completion()
////        //set the result in gameHistory
////        gameHistoryRef.setValue([kRESULT: "W", kOPPONENTUID: opponentUid]) { (error, ref) in
////            if let error = error {
////                completion(error.localizedDescription)
////            } else {
////                print("Finished saving the win")
//////                completion(nil)
////            }
////        }
////
////
//////grab the user's win, exp, level and update it
////        userRef.observeSingleEvent(of: .value, with: { (snap) in
////
//////            if snap.exists() {
//////            print("\n\ngame result Snap is \(snap)\n\n")
//////                guard let userDic = snap.value as? NSDictionary else { print("No userDic found")
////
////            if let userDic = snap.value as? NSDictionary {
//////                print("User dic in uploadGameResult = \(userDic)")
////                let wins = userDic[kWINS] as? Int ?? 0
////                let experience = userDic[kEXPERIENCES] as? Int ?? 0
////
////                userRef.updateChildValues([kWINS: wins + 1, kEXPERIENCES: experience + 100], withCompletionBlock: { (error, ref) in //LOOKING FOR KEXPERIENCE
////                    if let error = error {
////                        completion(error.localizedDescription)
////                    } else {
////                        print("Successfully updated wins stats and experience in firebase")
////                    }
////                })
////            } else {
////                userRef.setValue([kWINS: 1, kEXPERIENCES: 100], withCompletionBlock: { (error, ref) in
////                    print("This is first game ever, should only be printed once")
////
////                    if let error = error {
////                        completion(error.localizedDescription)
////
////                    } else {
////                        print("First game completed with a win!")
////
////                    }
////                })
////            }
////        }, withCancel: nil)
////
////    } else { //if userUid != game.winnerUid, meaning currentUser lose
////        print("current user lost")
////        gameHistoryRef.setValue(["result": "loser", "opponentUid": opponentUid]) { (error, ref) in
////            if let error = error {
////                completion(error.localizedDescription)
////            } else {
////                print("Finished saving the lose)")
////                ////                completion(nil)
////                //            }
////                //        }
////                //
////            } //end of no error on setting value on gameHistory
////        } //end of gameHistory.setValue
////
////        //        //grab the user's lose, exp, level and update it
////        userRef.observeSingleEvent(of: .value, with: { (snap) in
////            //            if snap.exists() {
////            //                guard let userDic = snap.value as? NSDictionary else { print("No userDic found"); return }
////            if let userDic = snap.value as? NSDictionary {
////                let loses = userDic[kLOSES] as? Int ?? 0
////                let experience = userDic[kEXPERIENCES] as? Int ?? 0
////
////                userRef.updateChildValues([kLOSES: loses + 1, kEXPERIENCES: experience + 10], withCompletionBlock: { (error, ref) in
////                    if let error = error {
////                        completion(error.localizedDescription)
////                    } else {
////                        print("Successfully updated lose stats and experience in firebase")
////                    }
////                })
////
////            } else {
////                userRef.setValue([kLOSES: 1, kEXPERIENCES: 10], withCompletionBlock: { (error, ref) in
////                    print("This is first game ever, should only be printed once")
////
////                    if let error = error {
////                        completion(error.localizedDescription)
//////                        return
////                    } else {
////                        print("First game completed with a LOSE!")
////
////                    }
////                })
////            } //end of user's 1st fighting game ever
////        }, withCancel: nil) //end of userRef.observeSingleEvent
////
////    } //end of if currentUser lose
////
//}


func fetchGameWith(gameSessionId: String, completion: @escaping (_ game: Game?) -> Void) { //used in PreGameVC
	//	let ref = firDatabase.child(kGAMESESSIONS).queryEqual(toValue: gameSessionId)
    let ref =  firDatabase.child(kGAMESESSIONS).child(gameSessionId)
    
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
        
        if snapshot.exists() {
            //            print("SNAPSHOT FROM FETCH GAMESESSION IS \(snapshot)")
            //            let userDictionary = ((snapshot.value as! NSDictionary).allValues as NSArray).firstObject! as! [String: AnyObject]
            let gameDictionary = snapshot.value as! [String: AnyObject]
            //            print("GAME DICTIONARY IS \(gameDictionary)")
            
            //            let gameUid: String = gameDictionary[kGAMESESSIONS] as! String
            
            let game = Game(_dictionary: gameDictionary)
            game.player1Image = downloadImage(fromLink: game.player1AvatarUrl!)
            game.player2Image = downloadImage(fromLink: game.player2AvatarUrl!)
            
            //            print("FETCHED GAME IS \(game)")
            completion(game)
        } else {
            print("ref doesn't exist")
            completion(nil) }
    }, withCancel: nil)
}

func downloadImage(fromURL url: URL) -> UIImage? {  //convert a url to a UIImage
//    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image: UIImage = UIImage(data: data)
            else { return }
        DispatchQueue.main.async() {
            
            return image
        }
        }.resume()
    return nil
}
func downloadImage(fromLink link: String) -> UIImage? {  //convert a link to a UIImage
    guard let url = URL(string: link) else { return nil }
    if let image: UIImage = downloadImage(fromURL: url) {
        return image
    } else {
        print("No user image found")
        return nil
    }
}

func gameDictionaryFrom(game: Game) -> NSDictionary {
    return NSDictionary(objects:[game.gameId, game.roundNumber, game.winnerUid ?? "", game.player1Name!, game.player1HP, game.player1Id!, game.player1AvatarUrl!, game.player2Name!, game.player2HP, game.player2Id!, game.player2AvatarUrl!, game.text ?? "", game.createdAt!, game.updatedAt!],
                        forKeys:[kGAMEID as NSCopying, kROUNDNUMBER as NSCopying, kWINNERUID as NSCopying, kPLAYER1NAME as NSCopying, kPLAYER1HP as NSCopying, kPLAYER1ID as NSCopying, kPLAYER1AVATARURL as NSCopying, kPLAYER2NAME as NSCopying, kPLAYER2HP as NSCopying, kPLAYER2ID as NSCopying, kPLAYER2AVATARURL as NSCopying, kTEXT as NSCopying, kCREATEDAT as NSCopying, kUPDATEDAT as NSCopying] ) //game.player1Image and player2Image seem to not work
}


func uploadCurrentUserSelectedTag(gameSessionId: String, p1OrP2String: String, turnCount: Int, currentUserTag: (Int?, Int?), completion: @escaping (_ error: Error?) -> Void) {
    let ref =  firDatabase.child(kGAMESESSIONS).child(gameSessionId).child(kCURRENTGAME).child(kROUNDS).child("\(turnCount)")

	var properties: [String: Int] = [:]
	
    
    let move = currentUserTag.0 == nil ? ["\(p1OrP2String)MoveTag": 1] : ["\(p1OrP2String)MoveTag": currentUserTag.0]
    let attack = currentUserTag.1 == nil ? ["\(p1OrP2String)MoveTag": 1] : ["\(p1OrP2String)AttackTag": currentUserTag.1]
    
	move.forEach {properties[$0] = $1}
	attack.forEach {properties[$0] = $1}
	ref.updateChildValues(properties) { (error, ref) in
		if let error = error {
			completion(error)
		} else {
			print("\(p1OrP2String)MoveTag was successfully uploaded")
			completion(nil)
		}
	}
}

func fetchOpponentSelectedTag(gameSessionId: String, p1OrP2String: String, turnCount: Int, completion: @escaping (_ opponentTag: (Int?, Int?)) -> Void) { //used in PreGameVC
    let ref =  firDatabase.child(kGAMESESSIONS).child(gameSessionId).child(kCURRENTGAME).child(kROUNDS).child("\(turnCount)")

	
    ref.observe(.value, with: { (snapshot) in
        print("Hey something was added at currentGame turn #\(turnCount)")
		if snapshot.exists() {
//            print("1")
			//			print("SNAPSHOT FROM FETCH opponent user IS \(snapshot)")
			//			let userDictionary = ((snapshot.value as! NSDictionary).allValues as NSArray).firstObject! as! [String: AnyObject]
//            print("SNAPSHOT is \(snapshot)")
            guard let resultDic = snapshot.value as? [String: AnyObject] else {
//                completion((0,0))
//                print("2")
                return
            }
//            print("Result Dic is \(resultDic)")
            guard let opponentMove = resultDic["\(p1OrP2String)MoveTag"] as? Int else { print("No opponentMove found"); return }
            guard let opponentAttack = resultDic["\(p1OrP2String)AttackTag"] as? Int else { print("No opponentAttack found"); return }
//            let opponentMoveTag = opponentMove == 0 ?  nil : opponentMove
//            let opponentAttackTag = opponentAttack == 0 ? nil : opponentAttack
//			print("Opponent Tag is \(opponentTag)")
			//			print("USER DICTIONARY IS \(userDictionary)")
//			let user = OpponentUser(_dictionary: userDictionary)
			
			completion((opponentMove, opponentAttack))
		} else { completion((nil,nil)) }
		
		
	}, withCancel: nil)
}

//date object and function
private let dateFormat = "yyyyMMddHHmmss" //RE ep.12 3mins made it private so it will remain constant and wont be changed at all outside of this file
func dateFormatter() -> DateFormatter { //RE ep.12 1min DateFormatter = A formatter that converts between dates and their textual representations.
    let dateFormatter = DateFormatter() //RE ep.12 2mins
    dateFormatter.dateFormat = dateFormat //RE ep.12 3mins
    
    return dateFormatter //RE ep.12 4mins
}
