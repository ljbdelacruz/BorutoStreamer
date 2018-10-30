//
//  EpisodeInfo.swift
//  BorutoStream
//
//  Created by Lainel John Dela Cruz on 30/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import Firebase

class EpisodeInfo{
    var id,title,source:String?;
    init(){
    }
    convenience init(id:String, title:String, source:String){
        self.init()
        self.set(id:id,title: title, source: source);
    }
    func set(id:String, title:String, source:String){
        self.id=id;
        self.title=title;
        self.source=source;
    }
    
    static func all(id:String, completionHandler: @escaping (EpisodeInfo?, String?)->()){
        let db=Database.database().reference().child("Anime").child(id).child("episodes");
        FirebaseCustom.RetrieveDataValue(db: db, completionHandler: {
            (ds) in
            let dict=ds!.value as! Dictionary<String, Any>;
            if ds != nil {
                completionHandler(EpisodeInfo.setup(key:ds!.key, ds: dict), nil);
            }else{
                completionHandler(nil, "sorry problem fetching animes")
            }
        })
    }
    
    static func setup(key:String, ds:[String:Any])->EpisodeInfo{
        let temp=EpisodeInfo();
        temp.set(id: key, title: ds["title"] as! String, source: ds["source"] as! String);
        return temp;
        
    }
}
