//
//  MessageTool.swift
//  iOSFirebaseSample
//
//  Created by RD-WilleyLo on 2019/3/7.
//  Copyright © 2019 HungCLo. All rights reserved.
//

import Foundation
import UIKit

class MessageTool {
    
    static func showMessage(msg: String) {
        let alertV = UIAlertController(title: "iOSFirebaseSample", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertV.addAction(alertAction)
        if let rootV = UIApplication.shared.keyWindow?.rootViewController  {
            rootV.present(alertV, animated: true, completion: nil)
        }
    }
    
    static func showMessageWithClosure(msg: String, next: @escaping () -> Void) {
        let alertV = UIAlertController(title: "iOSFirebaseSample", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "確定", style: .default, handler: {(_) in
            next()
        })
        alertV.addAction(alertAction)
        if let rootV = UIApplication.shared.keyWindow?.rootViewController  {
            rootV.present(alertV, animated: true, completion: nil)
        }
    }
}
