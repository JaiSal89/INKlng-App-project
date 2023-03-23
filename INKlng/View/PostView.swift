//
//  PostView.swift
//  INKlng
//
//  Created by Julian Salinas on 4/17/22.
//

import SwiftUI

struct PostView: View {
    var edges = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap { $0.windows }.first { $0.isKeyWindow }?.safeAreaInsets
    @StateObject var postData = PostViewModel()
    //var edges = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("Posts")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                Button(action: {postData.newPost.toggle()}) {
                    
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                        .foregroundColor(Color("blue"))
                }
            }
            .padding()
            .padding(.top,edges!.top)
            //Top shadow effect
            .background(Color("bg"))
            .shadow(color: Color.gray.opacity(0.06), radius: 5, x: 0, y: 5)
            
            if postData.posts.isEmpty{
                
                Spacer(minLength: 0)
                if postData.noPosts{
                    
                    Text("No Posts!!!")
                }
                else{
                    
                    ProgressView()
                }
                
                Spacer(minLength: 0 )
            }
            else{
                
                ScrollView{
                    
                    VStack(spacing: 15){
                        
                        ForEach(postData.posts){post in
                            
                            PostRow(post: post, postData: postData)
                        }
                    }
                    .padding()
                    .padding(.bottom,55)
                }
            }
        }
        .fullScreenCover(isPresented: $postData.newPost) {
            
            NewPost(updateId : $postData.updateId)
        }
    }
}
