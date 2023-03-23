//
//  ContentView.swift
//  INKlng
//
//  Created by Julian Salinas on 4/16/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("current_status") var status = false
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                if status{Home()}
                else{Login()}
            }
            .preferredColorScheme(.light)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
