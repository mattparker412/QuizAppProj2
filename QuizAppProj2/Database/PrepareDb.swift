//
//  PrepareDb.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/22/22.
//

import Foundation

class PrepareDb{
    
    func prepareDatabaseFile() -> String {
        
        let fileName: String = "quizzer.db"

               let fileManager:FileManager = FileManager.default
               let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

               let documentUrl = directory.appendingPathComponent(fileName)
               let bundleUrl = Bundle.main.resourceURL?.appendingPathComponent(fileName)

               // check if file already exists on simulator
               if fileManager.fileExists(atPath: (documentUrl.path)) {
                   print("document file exists!")
                   return documentUrl.path
               }
               else if fileManager.fileExists(atPath: (bundleUrl?.path)!) {
                   print("document file does not exist, copy from bundle!")
                   try! fileManager.copyItem(at:bundleUrl!, to:documentUrl)
               }

               return documentUrl.path
    }
}
