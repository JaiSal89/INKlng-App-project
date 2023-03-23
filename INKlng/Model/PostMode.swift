//
//  PostMode.swift
//  INKlng
//
//  Created by Julian Salinas on 4/18/22.
//

import SwiftUI

struct PostModel : Identifiable {
    
    var id: String
    var title : String
    var pic: String
    var time : Date
    var user: UserModel
}
