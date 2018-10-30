//
//  AnimeInfoViewController.swift
//  BorutoStream
//
//  Created by Lainel John Dela Cruz on 30/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import WebKit

class AnimeInfoViewController: UIViewController {
    
    @IBOutlet weak var UIVideoView: UIView!
    var UIWKVideo: WKWebView!
    @IBOutlet weak var UIBGImage: UIImageView!
    @IBOutlet weak var UIPImage: UIImageView!
    @IBOutlet weak var UIEpisodeTV: UITableView!
    @IBOutlet weak var UITitle: UILabel!
    @IBOutlet weak var UIScrollView: UIScrollView!
    var viewCompleteDelegate:ViewCompleteDelegate?;
    var animeInfo:AnimeInfo?;
    var index:Int=0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.UIEpisodeTV.delegate=self;
        self.UIEpisodeTV.dataSource=self;
        self.UIBGImage.image=FetchImage(imgurl: self.animeInfo?.BGImage ?? "", nimageURL: "nimage");
        self.UIPImage.image=FetchImage(imgurl: self.animeInfo!.PImage ?? "", nimageURL: "nimage")
        self.UITitle.text=self.animeInfo?.Title
        self.UIScrollView.contentSize=CGSize(width: UIScrollView.frame.width, height: (self.UIEpisodeTV.frame.height + self.UIVideoView.frame.height)+150);
        self.viewCompleteDelegate?.completeViewLoad();
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        UIWKVideo = WKWebView(frame: .zero, configuration: webConfiguration)
        UIWKVideo.uiDelegate = self
        UIWKVideo.frame=self.UIVideoView.frame;
        if self.animeInfo!.Prevideo! != nil{
            self.UIWKVideo.load(FirebaseCustom.toURLReq(url: FirebaseCustom.toURL(url: self.animeInfo!.Prevideo!)))
        }
                self.UIVideoView.addSubview(UIWKVideo);
        self.LoadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoToPlayVideo"{
            let destVC=segue.destination as! PlayVideoViewController;
            destVC.index=self.index;
            destVC.episodes=self.animeInfo?.episodes;
        }
    }
    
}

//MARK: -UITableView functionality
extension AnimeInfoViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animeInfo?.episodes.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.animeInfo?.episodes[indexPath.row].title as? String
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        self.index=indexPath.row;
        performSegue(withIdentifier: "infoToPlayVideo", sender: nil);
    }
    
}
//MARK: -UIImage func
extension AnimeInfoViewController{
    func FetchImage(imgurl:String, nimageURL:String)->UIImage{
        let url=FirebaseCustom.toURL(url: imgurl);
        if(url != nil){
            let data = try? Data(contentsOf: url)
            if let imageData = data {
                return UIImage(data: imageData)!;
            }else{
                return UIImage(named: "nimage")!
            }
        }
        return UIImage();
    }
    
}

//MARK: -UIWKWebView func
extension AnimeInfoViewController:WKUIDelegate{
}
//MARK: -Firebase FUNC
extension AnimeInfoViewController{
    func LoadData(){
        self.animeInfo?.episodes=[]
        EpisodeInfo.all(id: self.animeInfo!.ID!, completionHandler: {
            (data, err) in
            if err == nil {
                self.animeInfo?.episodes.append(data!);
                self.UIEpisodeTV.reloadData()
            }
        })
    }
}

