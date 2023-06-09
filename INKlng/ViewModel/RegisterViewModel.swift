//
//  RegisterViewModel.swift
//  INKlng
//
//  Created by Julian Salinas on 4/17/22.
//

import SwiftUI
import Firebase

class RegisterViewModel : ObservableObject{
    
    @Published var name = ""
    @Published var bio = ""
    
    @Published var image_Data = Data(count: 0)
    @Published var picker = false
    let ref = Firestore.firestore()
    //Loading View
    @Published var isLoading = false
    @AppStorage("current_status") var status = false
    
    func register(){
        
        isLoading = true
        //setting User Data to Firestore
        
        let uid = Auth.auth().currentUser!.uid
        
        UploadImage(imageData: image_Data, path: "profile_Photos") { (url) in
            
            self.ref.collection("Users").document(uid).setData([
                
                "uid": uid,
                "imageurl": url,
                "username": self.name,
                "bio": self.bio,
                "dateCreated": Date()
                
            ]) { (err) in
                
                if err != nil {
                    self.isLoading = false
                    return
                }
                self.isLoading = false
                //success means setting status as true
                self.status = true
            }
        }
    }
}
