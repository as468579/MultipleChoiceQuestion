//
//  InfoViewController.swift
//  MultipleChoiceQuestion
//
//  Created by User14 on 2019/5/1.
//  Copyright © 2019 ntou. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var sexChoice: UISegmentedControl!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var likelyhood: UISlider!
    @IBOutlet weak var likelyhoodLabel: UILabel!
    @IBOutlet weak var Done: UIButton!
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPage.isHidden = true
        nameText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func checkEmpty(_ sender: UIButton) {
        if nameText.text == ""{
            titleLabel.text = "請輸入姓名"
            titleLabel.textColor = UIColor.red
            return
        }
        
        if nameText.text != "彼得潘"{
            titleLabel.text = "只有彼得潘才能通過考驗"
            titleLabel.textColor = UIColor.red
            return
        }
        
        if sexChoice.selectedSegmentIndex == 1{
            titleLabel.text = "男生才是唯一選擇"
            titleLabel.textColor = UIColor.red
            return
        }
        
        if mySwitch.isOn == false{
            titleLabel.text = "沒有人不喜歡看小說"
            titleLabel.textColor = UIColor.red
            return
        }
        
        if likelyhood.value != 1{
            titleLabel.text = "你只能１００％的投入"
            titleLabel.textColor = UIColor.red
            likelyhoodLabel.text = String(format:"喜歡程度： %d",arguments:[likelyhood.value*100])
            return
        }
        
        if birthday.text == ""{
            titleLabel.text = "請輸入生日"
            titleLabel.textColor = UIColor.red
            return
        }
        
        Done.isHidden = true
        nextPage.isHidden = false
        
        
    }
    
    @IBAction func enterTheName(_ sender: UITextField) {
        if sender.text == ""{
            titleLabel.text = "請輸入姓名"
            titleLabel.textColor = UIColor.red
        }
        
        else if sender.text != "彼得潘"{
            titleLabel.text = "只有彼得潘才能通過考驗"
            titleLabel.textColor = UIColor.red
        }
        
        else if sender.text == "彼得潘"{
            titleLabel.text = ""
        }
        
    }
    
    @IBAction func chooseSex(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            titleLabel.text = "男生才是唯一選擇"
            titleLabel.textColor = UIColor.red
        }
        else{
            titleLabel.text = ""
        }
        
    }
    
    
    @IBAction func loveNovel(_ sender: UISwitch) {
        if sender.isOn == false{
            titleLabel.text = "沒有人不喜歡看小說"
            titleLabel.textColor = UIColor.red
        }
        else{
            titleLabel.text = ""
        }
    }
    
    @IBAction func chooseLikelyhood(_ sender: UISlider) {
        print(sender.value)
        if sender.value != 1{
            titleLabel.text = "你只能１００％的投入"
            titleLabel.textColor = UIColor.red
        }
        else{
            titleLabel.text = ""
        }
        likelyhoodLabel.text = String(format:"喜歡程度： %d",arguments:[(Int)(sender.value*100)])
    }
    
    @IBAction func pickBirthday(_ sender: UIDatePicker) {
        titleLabel.text = "對於生日我是很寬容的"
        titleLabel.textColor = UIColor.black
        let datevalue = DateFormatter()
        datevalue.dateFormat = "yyyy/MM/dd"
        birthday.text = datevalue.string(from: sender.date)
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
