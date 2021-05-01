//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Ahmet Yıldırım on 27.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var imgSave: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var txtGuess: UITextField!
    
    @IBOutlet weak var imgGuessStatus: UIImageView!
    
    @IBOutlet weak var btnTry: UIButton!
    
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet weak var imgStar1: UIImageView!
    
    @IBOutlet weak var imgStar2: UIImageView!
    
    @IBOutlet weak var imgStar3: UIImageView!
    
    @IBOutlet weak var imgStar4: UIImageView!
    
    @IBOutlet weak var imgStar5: UIImageView!
    
//  ekrandaki 5 tane yıldızı dizi halinde tutar
    var stars : [UIImageView] = [UIImageView]()
//  kullanıcının yapabileceği maksimum deneme sayisi
    let maxTrialNumber : Int = 5
//  kullanıcı kaç tane deneme yaptı
    var trialNumber : Int = 0
//  tahmin edilmesi gereken sayi
    var targetNumber : Int = -1
//  oyun başarılı bir şekilde sona ererse true olucak.
    var gameSuccessful : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stars = [imgStar1,imgStar2,imgStar3,imgStar4,imgStar5]
        
        imgSave.isHidden = true
        imgGuessStatus.isHidden = true
        btnTry.isEnabled = false
        txtNumber.isSecureTextEntry = true
        lblResult.text = ""
        
        
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        imgSave.isHidden = false
        if let t = Int(txtNumber.text!) {
            targetNumber = t
            txtNumber.isEnabled = false
            btnSave.isEnabled = false
            btnTry.isEnabled = true
            imgSave.image = UIImage(named: "onay")
        }else {
            imgSave.image = UIImage(named: "hata")
        }
        
    }
    
    @IBAction func btnTryClicked(_ sender: UIButton) {
//      kullanici oyunu bitirmişse herhangi birşey yapma geri dön
        if gameSuccessful == true || trialNumber > maxTrialNumber {
            return
        }
        
        if let g = Int(txtGuess.text!) {
//          eğer kullanıcı düzgün bir değer girdiyse
            
            trialNumber += 1
            stars[trialNumber-1].image = UIImage(named: "beyazYildiz")
            
            
            imgGuessStatus.isHidden = false
            if g > targetNumber {
                imgGuessStatus.image = UIImage(named: "aşaği")
                txtGuess.backgroundColor = UIColor.red
            }else if g < targetNumber {
                imgGuessStatus.image = UIImage(named: "yukari")
                txtGuess.backgroundColor = UIColor.red
            }else {
//                iki sayi birbirine eşittir.
//                oyuncu başarili bir şekilde tahmin etti.
                imgGuessStatus.image = UIImage(named: "onay")
                txtGuess.backgroundColor = UIColor.green
                btnTry.isEnabled = false
                lblResult.text = "Doğru Tahmin Ettiniz."
                txtNumber.isSecureTextEntry = false
                gameSuccessful = true
                
                let alertController = UIAlertController(title: "BAŞARILI!", message: "Sayıyı doğru tahmin ettiniz.", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                
                return
                
            }
            
        }else {
//       eğer kullanicinin girdiği değer düzgün değilse
            imgGuessStatus.isHidden = false
            imgGuessStatus.image = UIImage(named: "hata")
            let alertController = UIAlertController(title: "HATA!", message: "Sayisal bir değer girmeniz lazım.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
    
        }
        
        if trialNumber == maxTrialNumber {
            imgGuessStatus.image = UIImage(named: "hata")
            btnTry.isEnabled = false
            lblResult.text = "Oyun Başarısız!! \n Arkadaşın \(txtNumber.text!) sayisini girmişti."
            txtNumber.isSecureTextEntry = false
            
            let alertController = UIAlertController(title: "KAYBETTİNİZ!", message: "Bir dahaki sefere.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.destructive, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
    }
}

