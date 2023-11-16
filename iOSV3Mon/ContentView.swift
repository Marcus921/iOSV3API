//
//  ContentView.swift
//  iOSV3Mon
//
//  Created by Marcus Malmgren on 2023-11-13.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchtext = ""
    
    @StateObject var apiStuff = ChuckAPI()
    
    @State var showjoke = false
    
  
    
    var body: some View {
        
        ZStack {
            VStack {
                VStack {
                    
                    if apiStuff.thejoke != nil {
                        Text(ChuckHelper().fixdate(indate: apiStuff.thejoke!.created_at))
                        //Text(apiStuff.thejoke!.created_at)
                        Text(apiStuff.thejoke!.value)
                        
                        
                        Button(action: {
                            showjoke = true
                        }, label: {
                            Text("Show joke")
                        })
                        .sheet(isPresented: $showjoke, content: {
                            ShowJokeView(bigapi: apiStuff)
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200.0)
                .background(Color.fancyBlue)
                
                if apiStuff.errormessage != "" {
                    VStack {
                        Text("Error")
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 100.0)
                    .background(Color.red)
                }
                
                HStack {
                    TextField("Search Joke", text: $searchtext)
                        .onChange(of: searchtext) { oldValue, newValue in
                            print("Changing from \(oldValue) to \(newValue)")
                        }
                    
                    Button(action: {
                        apiStuff.loadapiForSearch(jokesearch: searchtext)
                    }, label: {
                        Text("Search")
                    })
                }
                
                Button(action: {
                    apiStuff.loadapiRandom()
                }, label: {
                    Text("Random Joke")
                })
                
                List {
                    ForEach(apiStuff.jokecategories, id: \.self) { cat in
                        /*
                         Button(action: {
                         loadapiForCategory(jokecat: cat)
                         }, label: {
                         Text(cat)
                         })
                         */
                        VStack {
                            Text(cat)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .onTapGesture {
                            apiStuff.loadapiForCategory(jokecat: cat)
                        }
                    }
                }
                
                
            }
            .padding()
            
            if apiStuff.isloading {
                VStack {
                    Text("Loading")
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .background(Color.gray)
                .opacity(0.5)
                
            }
            
        }
        .onAppear() {
                apiStuff.loadcategories()
        }
        .onChange(of: apiStuff.isloading) { oldValue, newValue in
            if(apiStuff.isloading) {
                print("Nu ladda")
            } else {
                print("Inte ladda mer")
            }
        }
    }
}

#Preview {
    ContentView()
}
