//
//  ChuckAPI.swift
//  iOSV3
//
//  Created by Marcus Malmgren on 2023-11-16.
//

import Foundation
import Observation

class ChuckAPI : ObservableObject{
    
    /*
     var fakeResult = "Tom från början"
     
     func fakeLoad()  {
     DispatchQueue.main.async {
     self.fakeResult = "Banan"
     }
     }
     */
    
    
    
    @Published var isloading = false
    
    @Published var jokecategories = [String]()
    
    @Published var thejoke : ChuckNorrisInfo?
    
    @Published var errormessage = ""
    
    func loadcategories() {
        Task {
            if ChuckHelper().isPreview {
                jokecategories = ["A", "B", "C"]
                return
            }
            
            let apiurl = URL(string: "https://api.chucknorris.io/jokes/categories")!
            
            DispatchQueue.main.async {
                self.isloading = true
            }
            do {
                isloading = true
                let (data, _) = try await URLSession.shared.data(from: apiurl)
                
                let decoder = JSONDecoder()
                
                DispatchQueue.main.async {
                    if let categories = try? decoder.decode([String].self, from: data) {
                        
                        self.jokecategories = categories
                    }
                    self.isloading = false
                }
            } catch {
                print("Error")
            }
        }
    }
    
    func loadapiForSearch(jokesearch: String)  {
        
        Task {
            await loadapi(apiurlstring: "https://api.chucknorris.io/jokes/search?query="+jokesearch)
        }
        
    }
    
    func loadapiForCategory(jokecat: String)  {
        
        Task {
            await loadapi(apiurlstring: "https://api.chucknorris.io/jokes/random?category="+jokecat)
        }
        
    }
    
    
    func loadapiRandom() {
        Task {
            await loadapi(apiurlstring: "https://api.chucknorris.io/jokes/random")
        }
    }
    
    func loadapi(apiurlstring : String) async {
        
        if ChuckHelper().isPreview {
            thejoke = ChuckNorrisInfo(id: "aaa", created_at: "xxx", value: "Joke joke joke")
            return
        }
        
        DispatchQueue.main.async {
            self.errormessage = ""
        }
        
        let apiurl = URL(string: apiurlstring)!
        
        do {
            DispatchQueue.main.async {
                self.isloading = true
            }
            let (data, _) = try await URLSession.shared.data(from: apiurl)
            
            let decoder = JSONDecoder()
            
            if let chuckthing = try? decoder.decode(ChuckNorrisInfo.self, from: data) {
                
                DispatchQueue.main.async {
                    self.thejoke = chuckthing
                }
            }
            
            if let chuckthing = try? decoder.decode(ChuckNorrisSearchResult.self, from: data) {
                
                if chuckthing.result.count > 0 {
                    DispatchQueue.main.async {
                        self.thejoke = chuckthing.result[0]
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errormessage = "Nothing found!"
                    }
                }
            }
        } catch {
            print("Error")
        }
        DispatchQueue.main.async {
            self.isloading = false
        }
        
    }
    
    func oldloadapi() async {
        
        let apiurl = URL(string: "https://api.chucknorris.io/jokes/random")!
        
        /*
         do {
         let apistring = try String(contentsOf: apiurl)
         print(apistring)
         joketext = apistring
         } catch {
         print("Error")
         }
         */
        
        do {
            let (data, _) = try await URLSession.shared.data(from: apiurl)
            
            let decoder = JSONDecoder()
            
            if let chuckthing = try? decoder.decode(ChuckNorrisInfo.self, from: data) {
                
                print(chuckthing.value)
                
                //thejoke = chuckthing.value
                
            }
            
            
            
        } catch {
            print("Error")
        }
    }
}
