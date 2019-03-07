//
//  LoginViewController.swift
//  iOSFirebaseSample
//
//  Created by RD-WilleyLo on 2019/3/7.
//  Copyright © 2019 HungCLo. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonDidPushed(_ sender: UIButton) {
        guard let account = accountTextField.text, let password = passwordTextField.text else {MessageTool.showMessage(msg: "請輸入帳號密碼"); return}
        guard account.count > 0 && password.count > 0 else {MessageTool.showMessage(msg: "請輸入帳號密碼"); return}
        Auth.auth().signIn(withEmail: account, password: password) { [weak self] user, error in
            guard let self = self else { return }
            if let _ = error {
                MessageTool.showMessage(msg: "您尚未註冊．")
            } else {
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "discussViewID") as? DiscussionViewController {
                    let nav = UINavigationController(rootViewController: viewController)
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }
    }
}
