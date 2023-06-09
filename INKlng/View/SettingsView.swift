//
//  SettingsView.swift
//  INKlng
//
//  Created by Julian Salinas on 4/17/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SettingsView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var settingsData = SettingsViewModel()
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
            }
            .padding()
            .padding(.top,edges!.top)
            //Top shadow effect
            .background(Color("bg"))
            .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
            
            if settingsData.userInfo.pic != ""{
                
                ZStack{
                    
                    WebImage(url: URL(string: settingsData.userInfo.pic)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                    
                    if settingsData.isLoading{
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("blue")))
                    }
                }
                .padding(.top,25)
                .onTapGesture {
                    settingsData.picker.toggle()
                }
            }
            
            
            HStack(spacing: 15){
                
                Text(settingsData.userInfo.username)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                //Edit button
                
                Button(action: {settingsData.updateDetails(field: "Name")}) {
                    
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            HStack(spacing: 15){
                
                Text(settingsData.userInfo.bio)
                    .foregroundColor(.gray)
                
                //Edit button
                
                Button(action: {settingsData.updateDetails(field: "Bio")}) {
                    
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
            }
            
            //Logout Button
            
            Button(action: settingsData.logOut, label: {
                Text("Log Out")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color("blue"))
                    .clipShape(Capsule())
            })
            .padding()
            .padding(.top,10)
            
            Spacer(minLength: 0)
        }
        .sheet(isPresented: $settingsData.picker) {
            
            ImagePicker(picker: $settingsData.picker, img_Data: $settingsData.img_data)
        }
        .onChange(of: settingsData.img_data) { (newData) in
            //whenever image is selected, update image in Firebase
            
            settingsData.updateImage()
        }
    }
}
