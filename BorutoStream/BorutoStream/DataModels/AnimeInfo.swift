//
//  AnimeInfo.swift
//  BorutoStream
//
//  Created by Lainel John Dela Cruz on 30/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import Firebase

class AnimeInfo{
    var BGImage,PImage,Title, Prevideo : String?;
    var episodes:[EpisodeInfo]=[];
    init(){
    }
    convenience init(bgimage:String, pimage:String, title:String, prev:String){
        self.init()
        self.set(bgimage: bgimage, pimage: pimage, title:title, prev: prev)
    }
    func set(bgimage:String, pimage:String, title:String, prev:String){
        self.BGImage=bgimage;
        self.PImage=pimage
        self.Title=title;
        self.Prevideo=prev;
    }
    static func all(completionHandler: @escaping (AnimeInfo?, String?)->()){
        let db=Database.database().reference().child("Anime");
        FirebaseCustom.RetrieveDataValue(db: db, completionHandler: {
            (ds) in
            let dict=ds!.value as! Dictionary<String, Any>;
            if ds != nil {
                completionHandler(AnimeInfo.setup(dict: dict), nil);
            }else{
                completionHandler(nil, "sorry problem fetching animes")
            }
        })
    }
    static func likeName(title:String, animes:[AnimeInfo])->[AnimeInfo]{
        return animes.filter({ ($0.Title?.contains(title))! })
    }
    static func setup(dict:[String:Any])->AnimeInfo{
        var temp=AnimeInfo();
        temp.set(bgimage: dict["bgimage"] as! String, pimage: dict["pimage"] as! String, title: dict["title"] as! String, prev:dict["prevideo"] as! String);
        return temp;
    }
    
    
    
    
}


