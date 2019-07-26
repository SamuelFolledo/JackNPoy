//
//  GameHistoryTableViewCell.swift
//  HawkHackProject2019S
//
//  Created by Samuel Folledo on 5/30/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit

class GameHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var opponentImageView: UIImageView!
    
    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    
    @IBOutlet weak var gameCoinsLabel: UILabel!
    @IBOutlet weak var gameExpLabel: UILabel!
    @IBOutlet weak var gameHPLabel: UILabel!
    @IBOutlet weak var gameResultButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(game: Game) {
        
//        var coinsValue: String?
//        var expValue: String?
//        var opponentNameValue: String?
//        var hpLeftValue: String?
//        var finishedAtValue: String?
        //opponentImage
        guard let updatedAt = game.updatedAt else { return }
//        let gameDate = dateFormatter().date(from: "\(updatedAt)")!
        gameDateLabel.text = "\(updatedAt)"
        
        guard let user = User.currentUser() else { return }
        let opponentUid: String = User.currentId() == game.player1Id ? game.player2Id! : game.player1Id! //if user is p1, then opponent is p2
        
        opponentImageView.downloaded(fromLink: opponentUid == game.player1Id ? game.player1AvatarUrl! : game.player2AvatarUrl!)
        
        guard let p1Name: String = game.player1Name else { return }
        guard let p2Name: String = game.player2Name else { return }
        opponentNameLabel.text = "\(opponentUid == game.player1Id ? p1Name : p2Name)" //if opponnetUid is p1, then opponentName is p1
        gameHPLabel.text = "\(game.winnerUid == game.player1Id ? game.player1HP : game.player2HP)"
        
        switch game.winnerUid {
        case user.userID:
            userWon()
        case opponentUid:
            userLost()
        default:
            print("Weird game uid = \(game.winnerUid)\ndoes not match any user uid")
        }
        
//        if opponentUid == game.player1Id && opponentUid == game.winnerUid! { //if opponent
//
//        }
        
//        if user.userID == game.winnerUid! && user.userID == game.player1Id { //p1 user is winner
//            opponentImageView.downloaded(fromLink: game.player2AvatarUrl!)
//            opponentNameLabel.text = "\(game.player2Name!)"
//            userWon()
//        } else if user.userID == game.winnerUid! && user.userID == game.player2Id { //p2 user is winner
//            opponentImageView.downloaded(fromLink: game.player1AvatarUrl!)
//            opponentNameLabel.text = "\(game.player1Name!)"
//            userWon()
//        } else if user.userID != game.winnerUid! && user.userID == game.player1Id { //p1 user is loser
//            opponentImageView.downloaded(fromLink: game.player2AvatarUrl!)
//            opponentNameLabel.text = "\(game.player2Name!)"
//            userLost()
//        } else if user.userID != game.winnerUid! && user.userID == game.player2Id { //p2 user is loser
//            opponentImageView.downloaded(fromLink: game.player1AvatarUrl!)
//            opponentNameLabel.text = "\(game.player1Name!)"
//            userLost()
//        } else {
//            print("user.userId is neither p1 or p2")
//        }
//
        
            
//        } else if game.winnerUid! == game.player2Id { //winner is p2
//            if user.userID == game.player12d { //if user is p1 then winner
//
//            } else { //user is p2 who is the loser
//
//            }
//        } else {
//            print("winner is neither or both p1 and p2?")
//        }
//
//        switch user.userID {
//        case game.player1Id:
//            opponentNameLabel.text = game.player2Name
//            opponentImageView.downloaded(fromLink: game.player2AvatarUrl!)
//
//            if game.player1Id == game.winnerUid { //if user is p1 and won
//                userWon()
//
//
//            } else { //if user is p1 and lost
//                userLost()
//            }
//        case game.player2Id:
//            opponentImageView.downloaded(fromLink: game.player1AvatarUrl!)
//            opponentNameLabel.text = game.player1Name
//
//            if game.player2Id == game.winnerUid {//if user is p2 and won
//                userWon()
//            } else {//if user is p2 and lost
//                userLost()
//            }
//        default:
//            print("user.userId is neither p1 or p2")
//        }


        
        

//        if game.player1Id == User.currentId() { //if p1 is our current user then opponent is p2
//            let opponentUid: String = User.currentId() == game.player1Id ? game.player2Id! : game.player1Id!
//            fetchOpponentUserWith(opponentUid: opponentUid) { (opponentUser) in
//                self.opponentImageView.downloaded(fromLink: opponentUser!.avatarURL)
//                self.opponentNameLabel.text = "\(opponentUser!.name)"
//            }
//
//        } else { //current user is p2
//            let opponentUid: String = game.player1Id!
//            fetchOpponentUserWith(opponentUid: opponentUid) { (opponentUser) in
//                self.opponentImageView.downloaded(fromLink: opponentUser!.avatarURL)
//                self.opponentNameLabel.text = "\(opponentUser!.name)"
//            }
//        }
//        let opponentUid: String = (game.player1Id == User.currentId() ? game.player2Id : game.player1Id)! //opponentUid will not be the current user
        
        
    }
    
    func userWon() {
        gameCoinsLabel.text = "+10"
        gameExpLabel.text = "+100"
        gameResultButton.setImage(UIImage(named: "WButton"), for: .normal)

    }
    
    func userLost() {
        gameCoinsLabel.text = "+1"
        gameExpLabel.text = "+10"
        gameResultButton.setImage(UIImage(named: "LButton"), for: .normal)
    }
    
}
