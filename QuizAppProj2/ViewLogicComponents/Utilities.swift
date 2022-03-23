//
//  Utilities.swift
//  CollectionDemo
//
//  Created by admin on 3/16/22.
//

import Foundation
import UIKit

class Utilities{
    

    static func styleButton(_ button: UIButton){
        // Filled rounded corner style
        button.backgroundColor = UIColor.black
        
        //(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        
        button.layer.cornerRadius = 15.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.tintColor = UIColor.white
    }
}
