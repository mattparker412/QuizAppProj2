//
//  ChatViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/22/22.
//

import UIKit
import MessageKit
import InputBarAccessoryView //sending message dependency

struct Sender : SenderType{
    var senderId: String
    var displayName: String
    
}
struct Message : MessageType{
    var sender: SenderType
    
    var messageId: String = ""
    
    var sentDate: Date
    
    var kind: MessageKind
    
    
}
class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate,InputBarAccessoryViewDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "iOS Academy")
    
    //users for displaying review history
    let otherUser = Sender(senderId: "other", displayName: "John Smith")
    var messageToAppend : String = ""
    var messages = [MessageType]()
    
    func currentSender() -> SenderType {
        return currentUser
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(userName!)
        print("message to append")
        print(messageToAppend)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        for index in 0..<db.getFeedBacks().count{
            var name = db.getFeedBacks()[index]["name"]
            var message = db.getFeedBacks()[index]["feedback"]
            print(name)
            print(message)
            name = db.getUserName(userId: Int(name!)!)
            message = message! + " - " + name!
            print(message!)
            messages.append(Message(sender: otherUser, messageId: String(messages.count+index+1), sentDate: Date(), kind: .text(message!)))
        }
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }
        func inputBar(_inputBar: InputBarAccessoryView, didPressSendButtonWith text: String){
            guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
                return
            }
            
    }
    
    

}
