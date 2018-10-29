//
//  AnimeInfoViewController.swift
//  BorutoStream
//
//  Created by Lainel John Dela Cruz on 30/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import AVKit

class AnimeInfoViewController: UIViewController {
    
    @IBOutlet weak var UIBGImage: UIImageView!
    @IBOutlet weak var UIPImage: UIImageView!
    @IBOutlet weak var UIEpisodeTV: UITableView!
    @IBOutlet weak var UIVideoPrevView: UIView!
    @IBOutlet weak var UITitle: UILabel!
    @IBOutlet weak var UIScrollView: UIScrollView!
    
    var animeInfo:AnimeInfo?;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.UIEpisodeTV.delegate=self;
        self.UIEpisodeTV.dataSource=self;
        self.UIBGImage.image=FetchImage(imgurl: self.animeInfo?.BGImage ?? "", nimageURL: "nimage");
        self.UIPImage.image=FetchImage(imgurl: self.animeInfo!.PImage ?? "", nimageURL: "nimage")
        self.UITitle.text=self.animeInfo?.Title
        FetchVideo(vidurl: self.animeInfo?.Prevideo ?? "", nvidURL: "")
        self.UIScrollView.contentSize=CGSize(width: UIScrollView.frame.width, height: self.UIEpisodeTV.frame.height+self.UIVideoPrevView.frame.height);
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
}
//MARK: -UIImage func
extension AnimeInfoViewController{
    func toURL(url:String)->URL{
        return URL(string: url)!;
    }
    func FetchImage(imgurl:String, nimageURL:String)->UIImage{
        let url=self.toURL(url: imgurl);
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
    func FetchVideo(vidurl:String, nvidURL:String){
        let url=self.toURL(url: vidurl);
        if url != nil {
            let player = AVPlayer(url: url);
            let avPreviewPlayer = AVPlayerViewController()
            avPreviewPlayer.player = player
            avPreviewPlayer.view.frame=UIVideoPrevView.bounds;
//            UIVideoPrevView.addSubview(avPreviewPlayer.view)
//            player.play();
            present(avPreviewPlayer, animated: true) {
                player.play()
            }
        }else{
            print("Video Returned nil");
        }
        

    }
    
}

