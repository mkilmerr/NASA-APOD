//
//  RemoteImage.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import SwiftUI

struct RemoteImage: View {
    let url: URL?
    
    init(url: URL?) {
        self.url = url
    }

    var body: some View {
        VStack {
            if let url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 300, height: 200)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(4)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    case .failure(_):
                        placeHolder()
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                placeHolder()
            }
        }
    }
    
    private func placeHolder() -> some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
            .foregroundColor(.gray)
    }
}

#Preview {
    RemoteImage(url: nil)
}
