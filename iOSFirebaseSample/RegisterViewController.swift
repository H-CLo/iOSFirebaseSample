//
//  RegisterViewController.swift
//  iOSFirebaseSample
//
//  Created by RD-WilleyLo on 2019/3/7.
//  Copyright © 2019 HungCLo. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonDidPushed(_ sender: UIButton) {
        guard let account = accountTextField.text, let password = passwordTextField.text else {MessageTool.showMessage(msg: "請輸入帳號密碼"); return}
        guard account.count > 0 && password.count > 0 else {MessageTool.showMessage(msg: "請輸入帳號密碼"); return}
        Auth.auth().createUser(withEmail: account, password: password, completion: {(authResult, error) in
            NSLog("AuthResult = \(String(describing: authResult))")
            NSLog("Error = \(String(describing: error))")
            if let _ = error {
                
            } else {
                MessageTool.showMessageWithClosure(msg: "註冊成功", next: {[weak self] () in
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        })
    }
}
