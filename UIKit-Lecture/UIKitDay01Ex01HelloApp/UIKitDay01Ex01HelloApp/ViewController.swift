//
//  ViewController.swift
//  UIKitDay01Ex01HelloApp
//
//  Created by 도민준 on 2/25/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lblHello: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 화면이 실행되고 바로 적용되는 초기화 영역
        
        // Hello를 안녕하세요로 보이게 변경
        lblHello.text = "안녕하세요!"
    }
    
    @IBAction func changeGreeting(_ sender: UIButton) {
        print("버튼 탭했다.")
        if btnSend == sender {
            print("버튼이 sender인 경우")
            // guard let name = txtName.text else { return }
            let name = txtName.text ?? "익명"
            print("텍스트 필드에 입력된 이름은 \(name)입니다.")
            lblHello.text = "\(name)님 안녕하세요!"
        } else {
            print("리셋버튼")
            // Reset 버튼을 누르면 모두 초기화 되도록
            lblHello.text = "Hello"
            txtName.text = ""
        }
    }
    
    
    
}

