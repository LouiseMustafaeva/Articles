//
//  NewsCell.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import SwiftUI

struct NewsCell: View {
    
    let title: String
    let subTitle: String
    var imageUrl: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(3)
                    .font(.headline)
                    .bold()
                    .listRowSeparator(.hidden)
                    .padding(.vertical)
                Text(subTitle)
                    .lineLimit(2)
                    .font(.subheadline)
            }
            Spacer()
            
            ImageView(urlString: imageUrl)
                .frame(width: 130, height: 110)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                )
                .cornerRadius(10)
            
                
        }.padding(.vertical)
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(title: "Stock market today: Live updates - CNBC", subTitle: "Stocks were little changed on Tuesday as Wall Street parsed through another round of inflation data in search for clues on when the Federal Reserve could start easing monetary policy.\r\nThe S&amp;P 50…", imageUrl: "camera.fill")
    }
}
