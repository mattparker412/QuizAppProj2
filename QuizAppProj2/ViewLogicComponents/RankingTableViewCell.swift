//
//  RankingTableViewCell.swift
//  QuizAppProj2
//
//  Created by admin on 3/25/22.
//

import UIKit

/// Cells that make up the ranking list
class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
