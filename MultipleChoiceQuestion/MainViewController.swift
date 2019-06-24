//
//  MainViewController.swift
//  MultipleChoiceQuestion
//
//  Created by User04 on 2019/4/25.
//  Copyright © 2019 ntou. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //Question label右邊的照片
    @IBOutlet weak var QuesImageView: UIImageView!
    @IBOutlet weak var QuesLabel: UILabel!
    @IBOutlet var roundImages: [UIImageView]! //choice button左邊的照片
    @IBOutlet var choiceBtn: [UIButton]!
    @IBOutlet weak var congrtulationLabel: UILabel!
    @IBOutlet weak var wrongAnswerLabel: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var choiceBtnImg: [UIImageView]!
    
    //記錄目前是第幾題
    var quesNumber:Int = 0
    var score:Int = 0
    
    //題目的資訊array
    let questions = ["Customer reviews indicate that many modern mobile devices are often unnecessarily ____.",
                     "Jamal Nawazd has received top performance reviews ____ he joined the sales department two years ago."]
    
    //所有選項資訊的array,第一題的選項為totalChoices[0][0]~totalChoices[0][3],以此類推
    let totalChoices = [["compliacation","complicates","compliacates","complicated"],
                   ["despite","expect","since","during"]]
    //答案資訊的array
    let answers = [4,3]
    
    //記錄目前的qna再qnas array中的位置
    var currentQna: Int?
    
    //紀錄每一題的題目,答案,選項
    var qnas = [Qna]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定初始介面
        QuesLabel.layer.borderWidth = 1
        QuesImageView.layer.shadowOpacity = 1
        for i in 0...3{
            choiceBtn[i].layer.borderWidth = 1
            choiceBtn[i].layer.shadowOpacity = 1
        }
        var images = [UIImage]()
        
        //設定QuesImageView的噴火龍
        for count in 0...60{
            let image = UIImage(named: String(format:"噴火龍-%d",count))!
            images.append(image)
        }
        let animatedImage = UIImage.animatedImage(with: images, duration: 2)
        QuesImageView.image = animatedImage
        
        //設定關卡數的圖片,第幾關就有幾隻皮卡丘
        for i in 0...quesNumber{
            roundImages[i].image = UIImage(named: "皮卡丘")
        }
        //設定每所有題目
        for i in 0...(questions.count-1){
            qnas.append(Qna(question:questions[i], answer:answers[i] , choices:totalChoices[i]))
        }
        
        //更新畫面
        finalScoreLabel.isHidden = true
        update()
        
        // Do any additional setup after loading the view.
    }
    

    //畫面點擊後會依sender.tag去比對qnas[currentQna].answer 若相同則執行congradulation()執行,反之執行wrongAnswer()
    @IBAction func choiceBtnPressed(_ sender: UIButton) {
        // 題號＋１
        quesNumber = quesNumber + 1
        if let currentQna = currentQna{
            print(sender.tag)
            print(qnas[currentQna].answer)
            if sender.tag == qnas[currentQna].answer{
                score += 50
                congratulation()
                // 加分未寫
            }
            else{
                wrongAnswer()
            }
        }
        
        // disable allChoiceBtn for animation
        for i in 0...3{
            choiceBtn[i].isEnabled = false
        }
        
    }
    
    //congratulation 動畫
    func congratulation(){
        congrtulationLabel.isHidden = false
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 4, delay: 0, animations: {
            self.congrtulationLabel.center = CGPoint(x: 520, y: self.congrtulationLabel.center.y)
        }) { (_) in
            self.congrtulationLabel.isHidden = true
            self.congrtulationLabel.center = CGPoint(x: -115, y: self.congrtulationLabel.center.y)
            if let currentQna = self.currentQna{
                self.qnas.remove(at: currentQna)
                if self.qnas.isEmpty{
                    // 結算分數
                    self.finalScoreLabel.text = String(format:"YOUR SCORE IS %d !!",arguments:[self.score])
                    self.finalScoreLabel.isHidden = false
                    
                    //uddate scoreLabel
                    self.scoreLabel.text = String(self.score)
                    
                    //The game end ,so the choice btns is hidden
                    for i in 0...3{
                        self.choiceBtn[i].isHidden = true
                        self.choiceBtnImg[i].isHidden = true
                    }
                    print("End!")
                }
                else{
                    self.update()
                }
            }
        }
    }
    
    //wrong anwser 動畫
    func wrongAnswer(){
        wrongAnswerLabel.isHidden = false
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 4, delay: 0, animations: {
            self.wrongAnswerLabel.center = CGPoint(x: 520, y: self.wrongAnswerLabel.center.y)
        }) { (_) in
            self.wrongAnswerLabel.isHidden = true
            self.wrongAnswerLabel.center = CGPoint(x: -115, y: self.wrongAnswerLabel.center.y)
            if let currentQna = self.currentQna{
                self.qnas.remove(at: currentQna)
                if self.qnas.isEmpty{
                    // 結算分數
                    self.finalScoreLabel.text = String(format:"YOUR SCORE IS %d !!",arguments:[self.score])
                    self.finalScoreLabel.isHidden = false
                    
                    //uddate scoreLabel
                    self.scoreLabel.text = String(self.score)
                    
                    //The game end ,so the choice btns is hidden
                    for i in 0...3{
                        self.choiceBtn[i].isHidden = true
                        self.choiceBtnImg[i].isHidden = true
                    }
                    
                    print("End!")
                }
                else{
                    self.update()
                }
            }
        }
    }
    
    func update(){
        congrtulationLabel.isHidden = true
        wrongAnswerLabel.isHidden = true
        scoreLabel.text = String(score)
        currentQna = Int.random(in:0...(qnas.count-1))
        
        //設定關卡數的圖片,第幾關就有幾隻皮卡丘

        for i in 0...quesNumber{
            roundImages[i].image = UIImage(named:"皮卡丘")
            
        }
        
        //animation is done ,so enable the choiceBtn
        for i in 0...3{
            choiceBtn[i].isEnabled = true
        }
        
        if let currentQna = currentQna{
            QuesLabel.text = qnas[currentQna].question
            for i in 0...3{
                choiceBtn[i].setTitle(qnas[currentQna].choices[i], for: .normal)
            }
            //qnas.remove(at: currentQna)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
