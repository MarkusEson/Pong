//
//  MenuVC.swift
//  Pong
//
//  Created by Markus Eriksson on 2018-04-07.
//  Copyright © 2018 Markus Eriksson. All rights reserved.
//

import Foundation
import UIKit

enum gameType{
    case easy
    case hard
}

class MenuVC : UIViewController {
    
    @IBAction func EasyGame(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    @IBAction func HardGame(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
