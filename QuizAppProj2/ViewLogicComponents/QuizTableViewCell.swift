//
//  QuizTableViewCell.swift
//  QuizAppProj2
//
//  Created by admin on 3/18/22.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    
    @IBOutlet weak var answerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
