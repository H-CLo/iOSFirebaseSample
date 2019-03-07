//
//  CommentViewController.swift
//  iOSFirebaseSample
//
//  Created by Hung Chang Lo on 2019/3/7.
//  Copyright © 2019 HungCLo. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // NSNumber, NSString, NSDictionary, and NSArray
    @IBAction func postMessageButtonDidPushed(_ sender: UIButton) {
        guard commentTextView.text.count > 0 else {MessageTool.showMessage(msg: "請輸入文字"); return}
        FirebaseDBManager.sharedInstance().updataChildValues(comment: commentTextView.text, next: {[weak self] () in
            guard let self = self else {return}
            self.navigationController?.popViewController(animated: true)
        })
    }
}
