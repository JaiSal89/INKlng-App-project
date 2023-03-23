//
//  LoginViewModel.swift
//  INKlng
//
//  Created by Julian Salinas on 4/16/22.
//

import SwiftUI
import Firebase

class LoginViewModel : ObservableObject{
    
    @Published var code = ""
    @Published var number = ""
    
    //For errors
    @Published var errorMsg = ""
    @Published var error = false
    
    @Published var registerUser = false
    @AppStorage("current_status") var status = false
    
    //Loading when searches for user
    @Published var isLoading = false
    
    func verifyUser(){
        
        isLoading = true
        //Remove When Testing In Live
        //Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let phoneNumber = "+" + code + number
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {
            (ID, err) in
            
            if err != nil {
                self.errorMsg = err!.localizedDescription
                self.error.toggle()
                self.isLoading = false
                return
            }
            
            //Code sent successfully
            
            self.alertView { (Code) in
                
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: ID!, verificationCode: Code)
                
                Auth.auth().signIn(with: credential) { (res, err) in
                    
                    if err != nil {
                        self.errorMsg = err!.localizedDescription
                        self.error.toggle()
                        self.isLoading = false
                        return
                    }
                    
                    self.checkUser()
                }
            }
        }
    }
    
    func alertView(completion: @escaping (String) -> ()){
        
        let alert = UIAlertController(title: "Verification", message: "Enter Code", preferredStyle: .alert)
        
        alert.addTextField { (txt) in
            txt.placeholder = "123456"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        alert.addAction(UIAlertAction(title: "Verify", style: .default, handler: { (_) in
            
            let code = alert.textFields![0].text ?? ""
            
            if code == ""{
                //Reprompting
                UIApplication.shared.connectedScenes.compactMap{
                    $0 as? UIWindowScene }.flatMap { $0.windows }.first { $0.isKeyWindow }?.rootViewController?.present(alert, animated: true)
                //UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
                return
            }
            completion(code)
        }))
        
        UIApplication.shared.connectedScenes.compactMap {
            $0 as? UIWindowScene }.flatMap { $0.windows }.first { $0.isKeyWindow }?.rootViewController?.present(alert, animated: true)
        //UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    func checkUser(){
        
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Users").whereField("uid", isEqualTo: uid).getDocuments {
            (snap, err) in
            
            if err != nil{
                //No documents
                //No user found
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            
            if snap!.documents.isEmpty{
                
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            self.status = true
        }
    }
}
