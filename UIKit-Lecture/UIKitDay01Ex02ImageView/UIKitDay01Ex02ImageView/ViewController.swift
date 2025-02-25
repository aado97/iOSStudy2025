//
//  ViewController.swift
//  UIKitDay01Ex02ImageView
//
//  Created by 도민준 on 2/25/25.
//

import UIKit

class ViewController: UIViewController {
    var isZoom = false
    var imageOn: UIImage?
    var imageOff: UIImage?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnZoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // #imageLiteral( --> 산모양 더블클릭
        imageOn = #imageLiteral(resourceName: "lamp_on")
        imageOff = UIImage(named: "lamp_off")
        
        imgView.image = imageOff
        
        let buttonImage = UIImage(systemName: "start.fill")
        btnZoom.setImage(buttonImage, for: .normal)
    }
    
    @IBAction func btnResizeImage(_ sender: UIButton) {
        var w: CGFloat = 0
        var h: CGFloat = 0
        let scale: CGFloat = 2
        
        if isZoom {
            print("축소")
            btnZoom.setTitle("확대", for: .normal)
            //isZoom = false
            w = imgView.frame.size.width / scale
            h = imgView.frame.height / scale
        } else {
            print("확대")
            btnZoom.setTitle("축소", for: .normal)
            //isZoom = true
            // 확대시키기
            // 현재 이미지의 사이즈에 2배
            w = imgView.frame.size.width * scale
            h = imgView.frame.height * scale
        }
        imgView.frame.size = CGSize(width: w, height: h)
        
        isZoom = !isZoom
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imageOn ?? imageOff
        } else {
            imgView.image = imageOff
        }
    }
    
}

