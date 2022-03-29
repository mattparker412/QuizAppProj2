//
//  FeedbackViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//

import UIKit
import AVFoundation
import Speech
import SideMenu

/// Creates display for feedback and implements functionality for voice recording and submitting feedback to DB
class FeedbackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MenuControllerDelegate {

    @IBOutlet weak var micro: UIButton!
    @IBOutlet weak var fdbackMsg: UILabel!
    @IBOutlet weak var submitted: UILabel!
    let audioEng = AVAudioEngine()
    let req = SFSpeechAudioBufferRecognitionRequest()
    let speechR = SFSpeechRecognizer()
    var rTask : SFSpeechRecognitionTask!
    var isStart = false
    var finalMsg : String?
    //can delete tableview stuff probably
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Reviews"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        vc.title = "Chat"
        self.present(vc, animated:false, completion: nil)
    }
    

    private var sideMenu: SideMenuNavigationController?
    let views = ["MyAccount","Subscription","Quizzes","Feedback","Ranking","Logout"]
    let menuCaller = CreateSideMenu()
    
    
    /// Opens side menu view when clicked
    @IBAction func didTapMenu(){
        present(sideMenu!, animated: true)
    }

    /// Selects row in table view of side menu and then navigates to the associated view controller to said row
    let navigator = NavigateToController()
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            var controllerToNav = self?.navigator.viewControllerSwitch(named: named)
            self?.navigator.navToController(current: self!, storyboard: controllerToNav![0] as! String, identifier: controllerToNav![1] as! String, controller: controllerToNav![2] as! UIViewController)

        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: views)
        menu.delegate = self
        sideMenu = menuCaller.displaySideMenu(sideMenu: sideMenu, menu: menu, view: view)
        
        fdbackMsg.numberOfLines = 10
        fdbackMsg.textColor = color
        submitted.textColor = color
    }

    
    /// Starts speech recognition
    func startSpeechRec(){
        finalMsg = ""
        fdbackMsg.text = ""
        submitted.text = ""
        let nd = audioEng.inputNode
        let recordF = nd.outputFormat(forBus: 0)
        nd.installTap(onBus: 0, bufferSize: 1024, format: recordF)
                      {
            (buffer , _ ) in self.req.append(buffer)
        }
        audioEng.prepare()
        do {
            try audioEng.start()
        }catch let err {
            printContent(err)
        }
        
        rTask  = speechR?.recognitionTask(with: req, resultHandler: {
            (resp, error) in
            
            guard let rsp = resp else{
                print(error.debugDescription)
                
                return
            }
            let msg = resp?.bestTranscription.formattedString
            self.finalMsg = msg
            
            var str : String = ""
            for seg in  resp!.bestTranscription.segments{
                let indexTo = msg!.index(msg!.startIndex, offsetBy: seg.substringRange.location)
                str = String(msg![indexTo...])
            }
        
        })
        
    }
    
    /// Cancels speech recognition
    func cancelSpeechRec(){
        rTask.finish()
        rTask.cancel()
        rTask = nil
        req.endAudio()
        audioEng.stop()
        
        if audioEng.inputNode.numberOfInputs > 0 {
            audioEng.inputNode.removeTap(onBus: 0)
        }
        print("final msg")
        print(finalMsg!)
        
        fdbackMsg.text = finalMsg!
        
        self.view.addSubview(fdbackMsg)
        
    }
    
    /// Submits message to DB
    @IBAction func submitMsg(_ sender: Any) {
        if(!(finalMsg ?? "").isEmpty && micro.currentTitle == "start"){
            db.saveFeedback(userId: userID!, feedBack: finalMsg!)
            submitted.text = "Submitted"
        } else {
            submitted.text = "No message to send"
        }
    }
    
    
    /// Acitavates microphone button and calls start or stop speech reconigiton functions in order to record voice
    @IBAction func activeMicro(_ sender: Any) {
        
        isStart = !isStart
        if isStart {
            startSpeechRec()
            micro.setTitle("stop", for: .normal)
            micro.tintColor = .red
        }else{
            cancelSpeechRec()
            micro.setTitle("start", for: .normal)
            micro.tintColor = .green

        }
    }
    
    /// Sends the submitted message to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let svc = segue.destination as!  ChatViewController
            svc.messageToAppend = finalMsg ?? ""
        }
    

}
