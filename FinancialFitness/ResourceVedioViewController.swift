//
//  ResourceVedioViewController.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class ResourceVedioViewController: UIViewController {
    
    @IBOutlet var videoWebView : UIWebView!
    @IBOutlet var videoDescription : UITextView!
    @IBOutlet var userVideoNote : UITextView!

    var resource : Resource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playVideo()
//        self.playVideo("90lQxO3ARmY")
  }
    
    func playVideo(){
        videoWebView.allowsInlineMediaPlayback = true
//        let youTubelink: String = "http://www.youtube.com/embed/\(videoId)"
        
        let videoUrl = resource?.videoUrlString
        let videoId = extractVideoId(videoUrl!)
        let videoUrlEmbedded: String = "http://www.youtube.com/embed/\(videoId)"
        let width = self.videoWebView.bounds.width;
        let height = self.videoWebView.bounds.height;
        let frame = 10;
        
        let Code:String = "<iframe width =\(width) height = \(height) src = \(videoUrlEmbedded) frameborder = \(frame)></iframe>";
        self.videoWebView.loadHTMLString(Code as String, baseURL: nil);
    }

    private func extractVideoId(videoUrl : String) -> String {
        var videoUrlArray = videoUrl.characters.split{$0 == "="}.map(String.init)
        var videoId: String = videoUrlArray[1]
        return videoId
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
