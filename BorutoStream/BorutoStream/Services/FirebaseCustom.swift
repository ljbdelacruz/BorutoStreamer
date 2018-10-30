//
//  FirebaseCustom.swift
//  SimpleChatMessaging
//
//  Created by Lainel John Dela Cruz on 12/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import Firebase

class FirebaseCustom{
    static func createUser(email:String, password:String, completionHandler: @escaping (Any?, Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user, error) in
            if error==nil{
                //success user created
                completionHandler(user, nil);
            }else{
                //print error
                completionHandler(nil, error);
            }
        })
    }
    static func AuthUser(email:String, password:String, completionHandler: @escaping (Any?, Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            (response, error) in
            if error==nil{
                completionHandler(response, nil);
            }else{
                completionHandler(nil, error);
            }
        })
    }
    static func Logout(completionHandler: @escaping (Bool) -> ()){
        do{
            try Auth.auth().signOut()
            completionHandler(true)
        }catch{
            completionHandler(false);
        }
    }
    static func InsertData(data:Any?, db:DatabaseReference, completionHandler: @escaping (Any?, Error?) -> ()){
        db.childByAutoId().setValue(data!){
            (error, ref) in
            if error == nil{
                completionHandler(ref, nil);
            }else{
                completionHandler(nil, error as! Error);
            }
        }
    }
    static func RetrieveDataValue(db:DatabaseReference, completionHandler: @escaping (DataSnapshot?) -> ()){
        db.observe(.childAdded, with: {
            (response) in
            completionHandler(response);
        })
    }
    static func CreateID(db:DatabaseReference)->String{
        let id=db.childByAutoId().description()
        print(id);
        return id;
    }
    static func toURL(url:String)->URL{
        return URL(string: url)!;
    }
    static func toURLReq(url:URL)->URLRequest{
        return URLRequest(url: url);
    }
    
}



