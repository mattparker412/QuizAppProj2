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
        
        //access data and append to messages array
        // can use -userName to indicate who sent message or we can try uploading images for the message display name
        messages.append(Message(sender: otherUser, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello World - John")))
        messages.append(Message(sender: currentUser, messageId: "2", sentDate: Date().addingTimeInterval(-70000), kind: .text("How is it going - Costin")))
        messages.append(Message(sender: otherUser, messageId: "3", sentDate: Date().addingTimeInterval(-50000), kind: .text("Here is a long reply - Matthew")))
        messages.append(Message(sender: currentUser, messageId: "4", sentDate: Date().addingTimeInterval(-40000), kind: .text("Long message Long message Long message Long message Long message")))
        messages.append(Message(sender: otherUser, messageId: "5", sentDate: Date().addingTimeInterval(-20000), kind: .text("Look, it works. Long messageLong message Long messageLong messageLong messageLong messageLong messageLong messageLong messageLong message")))
        messages.append(Message(sender: currentUser, messageId: "6", sentDate: Date().addingTimeInterval(-10000), kind: .text("Hahaha")))
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
        //print(db.getFeedBacks())
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }
    

        func inputBar(_inputBar: InputBarAccessoryView, didPressSendButtonWith text: String){
            guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
                return
            }
            //send message
            
    }
    
    

}
