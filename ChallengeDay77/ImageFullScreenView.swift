//
//  ImageFullScreenView.swift
//  ChallengeDay77
//
//  Created by Xiaolong Zhang on 9/28/20.
//

import SwiftUI

struct ImageFullScreenView: View {
    var inputImage: UIImage
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: inputImage)
                .resizable()
                .scaledToFit()
                .frame(minWidth: geometry.size.width)
        }
    }
}

struct ImageFullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFullScreenView(inputImage: UIImage(named: "800px-Pleiades_large") ?? UIImage())
    }
}
