//
//  AlertView.swift
//  INKlng
//
//  Created by Julian Salinas on 4/18/22.
//

import SwiftUI

func alertView(msg: String,completion: @escaping (String) -> ()){
    
    let alert = UIAlertController(title: "Message", message: msg, preferredStyle: .alert)
    
    alert.addTextField { (txt) in
        txt.placeholder = msg.contains("Verification") ? "123456" : ""
    }
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
    
    alert.addAction(UIAlertAction(title: msg.contains("Verification") ? "Verify" : "Update", style: .default, handler: { (_) in
        
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
