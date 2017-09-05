//
//  ViewController.swift
//  War
//
//  Created by Юлия on 03.08.17.
//  Copyright © 2017 Yulya Vasilyeva. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var LeftCard: UIImageView!
    @IBOutlet weak var RightCard: UIImageView!
    @IBOutlet weak var LeftLabel: UILabel!
    @IBOutlet weak var RightLabel: UILabel!
    @IBOutlet weak var preload: UIView!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var resultGame: UIView!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var resturtGameButton: UIButton!
    
    
    var countPl:Int = 0
    var countCPU:Int = 0
    
    var soundButton: AVAudioPlayer!
    var winSound: AVAudioPlayer!
    var looserSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load sound
        let path = Bundle.main.path(forResource: "button", ofType: "wav")!
        let path2 = Bundle.main.path(forResource: "Ta Da", ofType: "wav")!
        let path3 = Bundle.main.path(forResource: "Grenade", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        let url2 = URL(fileURLWithPath: path2)
        let url3 = URL(fileURLWithPath: path3)
        do{
            soundButton = try AVAudioPlayer(contentsOf: url)
            winSound = try AVAudioPlayer(contentsOf: url2)
            looserSound = try AVAudioPlayer(contentsOf: url3)
            
            soundButton.prepareToPlay()
            winSound.prepareToPlay()
            looserSound.prepareToPlay()
            
        }catch let error as NSError{
            print(error.description)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*action when we pressed preload button Play*/
    @IBAction func buttonPlayPressed(_ sender: Any) {
        preload.isHidden = true
    }
    
    
/* function for get random number and return number and name of card*/
    func randomCardName() -> (String, Int) {
        let rand = Int(arc4random_uniform(13))+2
        var nameCard:String = ""
        
        switch rand{
        case 11: nameCard = "jack"
        case 12: nameCard = "queen"
        case 13: nameCard = "king"
        case 14: nameCard = "ace"
        default: nameCard = "card\(rand)"
        }
        return (nameCard, rand)
    }
    
/* action when we pressed the button Deal*/
    @IBAction func DealTapped(_ sender: UIButton) {
        /* play sound */
        soundButton.play()
        
       /* change card */
        let (randResultNameLeft, randResultIndxLeft) = randomCardName()
        let (randResultNameRight, randResultIndxRight) = randomCardName()
        
        LeftCard.image = UIImage(named: randResultNameLeft)
        RightCard.image = UIImage(named: randResultNameRight)
       
        
        var leftCardFrame: CGRect!
        var rightCardFrame: CGRect!
        /* animate card*/
        UIView.animate(withDuration: 0.2, animations: {
            
            leftCardFrame = self.LeftCard.frame
            rightCardFrame = self.RightCard.frame

            self.LeftCard.frame = CGRect(x: leftCardFrame.origin.x - 5, y: 0, width: leftCardFrame.size.width, height: leftCardFrame.size.height)
            self.RightCard.frame = CGRect(x: rightCardFrame.origin.x + 5, y: 0, width: rightCardFrame.size.width, height: rightCardFrame.size.height)
            
        }){ (finished) in
            
            self.LeftCard.frame = leftCardFrame
            self.RightCard.frame = rightCardFrame
        }
        
        /* count score */
        if randResultIndxLeft>randResultIndxRight{
            countPl += 1
        }
        else{
            if randResultIndxLeft < randResultIndxRight{
                countCPU += 1
            }
        }
        LeftLabel.text = String (countPl)
        RightLabel.text = String(countCPU)
        
        /* result of the Game*/
        if countPl == 12{
            resultGame.isHidden = false
        }
        if countCPU == 12{
            resultGame.isHidden = false
            resultGame.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.3, alpha: 1.0)
            labelResult.text = "You loose!!!"
        }
        
    }
    @IBAction func restartButton(_ sender: UIButton) {
        countPl = 0
        countCPU = 0
        resultGame.isHidden = true
        preload.isHidden = false
    }

}

