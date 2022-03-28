//
//  CustomCollectionViewCell.swift
//  CollectionDemo
//
//  Created by admin on 25/02/22.
//



import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var mlb1: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
       // layer.frame.
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.backgroundColor = UIColor.white.cgColor
        backgroundColor = UIColor.blue
}

    @IBAction func buttonPressed(_ sender: Any) {
    }
    

    
    

    
    
}
