//
//  NewPostModel.swift
//  INKlng
//
//  Created by Julian Salinas on 4/18/22.
//

import SwiftUI
import Firebase

/*class NewPostModel : ObservableObject{
    
    @Published var postTxt = ""
    //Image picker
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    
    //Disabling controls while posting
    @Published var isPosting = false
    
    let uid = Auth.auth().currentUser!.uid
    
    func post (present : Binding<PresentationMode>){
        
        //Posting data from new post to firebase
        
        func post() {
            
            //posting data
            
            isPosting = true
            
            if img_Data.count == 0{
                
                ref.collection("Posts").document().setData([
                    
                    "title": self.postTxt,
                    "url": "",
                    "ref": ref.collection("Users").document(self.uid),
                    "time": Date()
                    
                ]) { (err) in
                    
                    if err != nil{
                        self.isPosting = false
                        return
                    }
                    
                    self.isPosting = false
                    //closing View when successfully posted
                    present.wrappedValue.dismiss()
                }
            }
            else{
                
                UploadImage(imageData: img_Data, path: "post_Pics") { (url) in
                    
                    ref.collection("Posts").document().setData([
                        
                        "title": self.postTxt,
                        "url": url,
                        "ref": ref.collection("Users").document(self.uid),
                        "time": Date()
                        
                    ]) { (err) in
                        
                        if err != nil{
                            self.isPosting = false
                            return
                        }
                        
                        self.isPosting = false
                        //closing View when successfully posted
                        present.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}*/
class NewPostModel : ObservableObject{
    
    @Published var postTxt = ""
    // Image Picker...
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    
    // disabling all controls while posting...
    @Published var isPosting = false
    
    let uid = Auth.auth().currentUser!.uid
    
    func post(updateId: String,present : Binding<PresentationMode>){
        
        //Post data
        
        isPosting = true
        
        if updateId != ""{
            
            //Updating data
            
            ref.collection("Posts").document(updateId).updateData([
            
                "title": postTxt
            ]) { (err) in
                
                self.isPosting = false
                if err != nil{return}
                
                present.wrappedValue.dismiss()
            }
            
            return
        }
        
        if img_Data.count == 0{
            
            ref.collection("Posts").document().setData([
            
                "title": self.postTxt,
                "url": "",
                "ref": ref.collection("Users").document(self.uid),
                "time": Date()
                
            ]) { (err) in
                
                if err != nil{
                    self.isPosting = false
                    return
                }
                
                self.isPosting = false
                // closing View When Succssfuly Posted...
                present.wrappedValue.dismiss()
            }
        }
        else{
            
            UploadImage(imageData: img_Data, path: "post_Pics") { (url) in
                
                ref.collection("Posts").document().setData([
                
                    "title": self.postTxt,
                    "url": url,
                    "ref": ref.collection("Users").document(self.uid),
                    "time": Date()
                    
                ]) { (err) in
                    
                    if err != nil{
                        self.isPosting = false
                        return
                    }
                    
                    self.isPosting = false
                    // closing View When Succssfuly Posted...
                    present.wrappedValue.dismiss()
                }
            }
        }
    }
}
