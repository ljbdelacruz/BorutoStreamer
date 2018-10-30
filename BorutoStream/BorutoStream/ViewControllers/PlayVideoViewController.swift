//
//  PlayVideoViewController.swift
//  BorutoStream
//
//  Created by Lainel John Dela Cruz on 30/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import WebKit

class PlayVideoViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var UIVideoPlayerView: UIView!
    var index:Int?;
    var episodes:[EpisodeInfo]?
    var UIWKVideo: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: -UIWKVideo func
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        UIWKVideo = WKWebView(frame: .zero, configuration: webConfiguration)
        UIWKVideo.frame=self.UIVideoPlayerView.frame;
        UIWKVideo.uiDelegate = self
        if self.episodes != nil && self.index != nil {
            self.UIWKVideo.load(FirebaseCustom.toURLReq(url: FirebaseCustom.toURL(url: self.episodes![index!].source!)))
        }
        self.UIVideoPlayerView.addSubview(UIWKVideo);
    }
}

