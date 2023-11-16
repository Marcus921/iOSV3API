//
//  ShowJokeView.swift
//  iOSV3
//
//  Created by Marcus Malmgren on 2023-11-16.
//

import SwiftUI

struct ShowJokeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    //@StateObject var apiStuff = ChuckAPI()
    
    //@State var bigjoke : ChuckNorrisInfo
    
    @StateObject var bigapi : ChuckAPI
    
    var body: some View {
        VStack {
            Text(bigapi.thejoke!.value)
                .font(.largeTitle)
            
            Button(action: {
                bigapi.loadapiRandom()
            }, label: {
                Text("Random")
            })
            
            Button(action: {
                dismiss()
            }, label: {
                Text("Close")
            })
        }
    }
}

#Preview {
    ShowJokeView(bigapi: ChuckAPI())
}
