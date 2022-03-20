//
//  FeedbackViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//

import UIKit
import AVFoundation
import Speech

class FeedbackViewController: UIViewController {

    @IBOutlet weak var micro: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let audioEng = AVAudioEngine()
    let req = SFSpeechAudioBufferRecognitionRequest()
    let speechR = SFSpeechRecognizer()
    var rTask : SFSpeechRecognitionTask!
    var isStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            self.label.text = msg!
            
            
            
            var str : String = ""
            for seg in  resp!.bestTranscription.segments{
                let indexTo = msg!.index(msg!.startIndex, offsetBy: seg.substringRange.location)
                str = String(msg![indexTo...])
            }
        
        })
        
        
        print("start")
    }
    
    func cancellSpeechRec(){
        rTask.finish()
        rTask.cancel()
        rTask = nil
        req.endAudio()
        audioEng.stop()
        
        if audioEng.inputNode.numberOfInputs > 0 {
            audioEng.inputNode.removeTap(onBus: 0)
        }
        print("cancel")
    }
    
    @IBAction func activeMicro(_ sender: Any) {
        isStart = !isStart
        if isStart {
            startSpeechRec()
            micro.setTitle("stop", for: .normal)
            micro.tintColor = .blue
            
         //   sender.setTitle("stop", for: .normal)
        }else{
            cancellSpeechRec()
            micro.setTitle("start", for: .normal)
            micro.tintColor = .red
          //  sender.setTitle("start", for: .normal)
        }
    }
    

}
