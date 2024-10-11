//
//  LoadingIndicatorView.swift
//  MovieHouse
//
//  Created by Nitish Jain on 04/10/24.
//

import SwiftUI

struct LoadingIndicatorView: View {
    
    let isLoading: Bool
    let error: NSError?
    let retryAction: (() -> Void)?
    
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text(error!.localizedDescription)
                            .font(.headline)
                        if self.retryAction != nil {
                            Button {
                                retryAction
                            } label: {
                                Text("Retry")
                                    .font(.body)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoadingIndicatorView(isLoading: true, error: nil, retryAction: nil)
}
