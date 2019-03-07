//
//  CommentTableViewCell.swift
//  iOSFirebaseSample
//
//  Created by Hung Chang Lo on 2019/3/7.
//  Copyright © 2019 HungCLo. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        commentLabel.text = nil
        createTimeLabel.text = nil
    }

}
