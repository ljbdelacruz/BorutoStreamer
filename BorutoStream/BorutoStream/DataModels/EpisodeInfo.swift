//
//  EpisodeInfo.swift
//  BorutoStream
//
//  Created by Lainel John Dela Cruz on 30/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation

class EpisodeInfo{
    var title,source:String?;
    init(){
    }
    convenience init(title:String, source:String){
        self.init()
        self.set(title: title, source: source);
    }
    func set(title:String, source:String){
        self.title=title;
        self.source=source;
    }
}
