//
//  FirebaseDBManager.swift
//  iOSFirebaseSample
//
//  Created by Hung Chang Lo on 2019/3/7.
//  Copyright © 2019 HungCLo. All rights reserved.
//

import Foundation
import FirebaseDatabase

private let shared_DBManager = FirebaseDBManager()

class FirebaseDBManager {
    
    class func sharedInstance() -> FirebaseDBManager {
        return shared_DBManager
    }
    
    var ref: DatabaseReference = Database.database().reference()
    
    // 更新節點資料
    
    func updataChildValues(comment: String, next: @escaping () -> Void) {
        let newRef = ref.child("movieReviews").child("movieId-00001")
        let childRef = newRef.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        guard let key = childRef.key else {return}
        var movieReviews = [AnyHashable: Any]()
        movieReviews["movieName"] = "玩命關頭8"
        movieReviews["movieReviews"] = comment
        movieReviews["createTime"] = getCurrentDateStr()
        movieReviews["childKey"] = key
        let movieReviewReference = newRef.child(key)
        movieReviewReference.updateChildValues(movieReviews, withCompletionBlock: {
            (err, refResult) in
            if let existedErr = err {
                print("Error = \(existedErr)")
                return
            }
            
            print("RefResult = \(refResult.description())")
            next()
        })
    }
    
    private func getCurrentDateStr() -> String {
        let date = Date()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    // 查詢節點資料
    
    func getChildValues(next: @escaping (([AnyHashable: Any]) -> Void)) {
        ref.child("movieReviews").child("movieId-00001").observe(.value, with: {(snapshot) in
            guard let value = snapshot.value else {next([AnyHashable: Any]()); return}
            if let dictionaryData = value as? [String: AnyObject] {
                next(dictionaryData)
                print(dictionaryData)
                print(snapshot.key)
            }
        })
    }
    
    func removeChildValue(key: String, next: @escaping () -> Void) {
        ref.child("movieReviews").child("movieId-00001").child(key).removeValue(completionBlock: {(err, refResult) in
            if let error = err {
                print("Error = \(error.localizedDescription)")
                return
            }
            
            print("Remove data success")
            next()
        })
    }
}
