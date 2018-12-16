//
//  PostRequest.swift
//  Surya-test
//
//  Created by Arinjay on 09/12/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import Foundation

class PostRequest {
    typealias updateSearchResult = (ResponseResult?,String) -> ()

    var responseData : ResponseResult?
    var errorMessage = ""
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    
    func getResult(searchKeyword:String,completion: @escaping updateSearchResult ) {
        dataTask?.cancel()

        var responseCache = ResponseCache.get().readCache(searchKey: searchKeyword as NSString)
        if responseCache != nil {
            self.updateSearchResults(responseCache!)
            DispatchQueue.main.async {
                completion(self.responseData, self.errorMessage)
            }
            return
        }
        
        if(searchKeyword == "") {
            DispatchQueue.main.async {
                self.errorMessage = "keyword cannot be null"
                completion(self.responseData, self.errorMessage)
            }
            return
        }

        var httpBodyRequest = ["emailId":"<\(searchKeyword)>"]


        let url = "http://surya-interview.appspot.com/list"
        guard let Url = URL(string: url) else {print("URL Error"); return}
        var request = URLRequest(url:Url)
        request.httpMethod = "POST"

        guard let httpBody = try? JSONSerialization.data(withJSONObject: httpBodyRequest, options: JSONSerialization.WritingOptions.prettyPrinted) else { print("Error in HTTPBody")
            return
        }

        request.httpBody = httpBody

        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                ResponseCache.get().writeCache(searchKey: searchKeyword, result: data)
                self.updateSearchResults(data)
                DispatchQueue.main.async {
                    completion(self.responseData, self.errorMessage)
                }
            } else {
                print(error as Any)
            }
        }
        dataTask?.resume()

    }

    fileprivate func updateSearchResults(_ data: Data) {
        do {
            let fetchedSyllabustRes = try JSONDecoder().decode(ResponseResult.self, from: data)
            responseData = (fetchedSyllabustRes)
        }
        catch let parseError as NSError {
            errorMessage += "Response parsing error: \(parseError.localizedDescription)\n"
            print(errorMessage, "= error")
        }
    }

}
