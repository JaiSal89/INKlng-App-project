//
//  UploadImage.swift
//  INKlng
//
//  Created by Julian Salinas on 4/17/22.
//

import SwiftUI
import Firebase

func UploadImage(imageData: Data,path: String,completion: @escaping (String) -> ()) {
    
    let storage = Storage.storage().reference()
    let uid = Auth.auth().currentUser!.uid
    
    storage.child(path).child(uid).putData(imageData, metadata: nil) { (_, err) in
        if err != nil{
            completion("")
            return
            
        }
        
        //Downloading URL and sending back
        storage.child(path).child(uid).downloadURL { (url, err) in
            if err != nil {
                completion("")
                return
            }
            
            completion("\(url!)")
        }
    }
}
