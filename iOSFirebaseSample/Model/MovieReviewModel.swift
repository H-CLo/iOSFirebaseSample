//
//  MovieReviewModel.swift
//  iOSFirebaseSample
//
//  Created by Hung Chang Lo on 2019/3/7.
//  Copyright © 2019 HungCLo. All rights reserved.
//

import Foundation

struct MovieReviewModel {
    
    var movieName: String
    var movieReviews: String
    var createTime: String
    var childKey: String
    
    init(info: [AnyHashable: Any]) {
        movieName = info["movieName"] as? String ?? ""
        movieReviews = info["movieReviews"] as? String ?? ""
        createTime = info["createTime"] as? String ?? ""
        childKey = info["childKey"] as? String ?? ""
    }
}
