//
//  DetailScene.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import SwiftUI

struct DetailScene: View {
    
     var imageUrl: String
     var title: String
     var author: String
     var date: String
     var content: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ImageView(urlString: imageUrl)
                .frame(height: 220)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                )
                .cornerRadius(10)
            
            
            Text(author)
                .lineLimit(1)
                .foregroundColor(.gray)
                .font(.subheadline)
                .padding(.vertical)
            
            Text(date)
                .lineLimit(1)
                .foregroundColor(.gray)
                .font(.subheadline)
            
            Text(title)
                .foregroundColor(.black)
                .font(.headline)
                .padding(.vertical)
            
            Text(content)
                .foregroundColor(.gray)
                .font(.headline)
                Spacer()
            
        }
        .padding()
        Spacer()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
    }
        
}

struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
        DetailScene(imageUrl: "", title: "", author: "", date: "", content: "")
    }
}
