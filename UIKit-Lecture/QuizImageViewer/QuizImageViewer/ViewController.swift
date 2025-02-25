//
//  ViewController.swift
//  QuizImageViewer
//
//  Created by 도민준 on 2/25/25.
//

import UIKit

class ViewController: UIViewController {

    var img: UIImage?
    var num: Int = 1
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        img = UIImage(named: "\(num).png")
        mainImageView.image = img
    }

    
    @IBAction func nextBtn(_ sender: UIButton) {
        guard num < 6 else { return }
        num += 1
        img = UIImage(named: "\(num).png")
        mainImageView.image = img
    }
    
    @IBAction func prevBtn(_ sender: UIButton) {
        guard num > 1 else { return }
        num -= 1
        img = UIImage(named: "\(num).png")
        mainImageView.image = img
    }
    
}

