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

class FeedbackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var micro: UIButton!
    let audioEng = AVAudioEngine()
    let req = SFSpeechAudioBufferRecognitionRequest()
    let speechR = SFSpeechRecognizer()
    var rTask : SFSpeechRecognitionTask!
    var isStart = false
    var finalMsg : String?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Reviews"
        return cell
    }
    
    //something happens when cell clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //show chat messages
        print("clicked")
        let vc = ChatViewController()
        vc.title = "Chat"
        //navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated:false, completion: nil)
    }
    

    
    @IBOutlet var myTable : UITableView!
    
    var menu: SideMenuNavigationController?
    let createMenu = CallMenuList()
    
    
    @IBAction func didTapMenu(){
        present(menu! ,animated: true)
        //let menulist = MenuListController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = createMenu.setUpSideMenu(menu: menu, controller: self)
        // Do any additional setup after loading the view.
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.delegate = self
        myTable.dataSource = self
        
        let db = DBHelper()
        
        let feedBacks = db.getFeedBacks()
           //print(feedBacks)
           
           for f in feedBacks{
               print(f["name"]! + " ----> " + f["feedback"]!)
           }
    }

    
    func startSpeechRec(){
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
            print(msg)
            self.finalMsg = msg
            
            var str : String = ""
            for seg in  resp!.bestTranscription.segments{
                let indexTo = msg!.index(msg!.startIndex, offsetBy: seg.substringRange.location)
                str = String(msg![indexTo...])
            }
        
        })
        
    }
    
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
    }
    
    @IBAction func submitMsg(_ sender: Any) {
        if(!(finalMsg ?? "").isEmpty && micro.currentTitle == "start"){
            //send data to database
            //store message id
            // message in finalMsg
            print("data saved to db")
        } else {
            print("no message to send")
        }
    }
    @IBAction func activeMicro(_ sender: Any) {
        isStart = !isStart
        if isStart {
            startSpeechRec()
            micro.setTitle("stop", for: .normal)
            micro.tintColor = .red
            
         //   sender.setTitle("stop", for: .normal)
        }else{
            cancelSpeechRec()
            micro.setTitle("start", for: .normal)
            micro.tintColor = .green
            
            
          //  sender.setTitle("start", for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("enter prepare")
        let svc = segue.destination as!  ChatViewController
            svc.messageToAppend = finalMsg!
        }
    

}
