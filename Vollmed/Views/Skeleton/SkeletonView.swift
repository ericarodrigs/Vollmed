//
//  SkeletonView.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 14/10/25.
//

import SwiftUI

struct SkeletonView: View {
    var body: some View {
        VStack(spacing: 35) {
            ForEach(0..<4, id: \.self) {index in
                SkeletonRow()
            }
        }
    }
}

struct SkeletonRow: View {
    private var placeHolderString = "***************************"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                    .mask (
                        Circle()
                            .frame(width: 60, height: 60, alignment: .leading)
                            .redactedAnimation()
                    )
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 8) {
                    LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                        .mask (
                            Text(placeHolderString)
                                .redacted(reason: .placeholder)
                                .redactedAnimation()
                        )
                    
                    LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                        .mask (
                            Text(placeHolderString)
                                .redacted(reason: .placeholder)
                                .redactedAnimation()
                        )
                }
            }
            
        }
    }
}

#Preview {
    SkeletonView()
}
