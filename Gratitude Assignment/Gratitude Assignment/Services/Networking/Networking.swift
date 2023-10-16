//
//  Networking.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import Foundation


public protocol Networking{
    func postJSON<E:Encodable, D:Decodable>(url urlString:String,requestData:E,responseType:D.Type)async throws->D
    func postJSONFormData<D:Decodable>(url urlString:String,requestData:[String:Any],responseType:D.Type)async throws->D
    func getJSON<T:Decodable>(url urlString:String,type:T.Type)async throws -> T
}


public protocol NetworkingHelper{
    func makeRequest(url urlString:String)throws ->URLRequest
    func decodeData<T:Decodable>(data:Data,type:T.Type)throws->T
    func getPostString(params:[String:Any]) -> String
}


/*
 Task --> .yield()
 Priority of Tasks
 
 Child task inherentane from parent task
 -> .detached() { DO NOT USE! }
 -> Task Group
 -> Cancel Task (or) use .task{ } modifier, it handles cancelling for tasks
    -> Check cancellation
 -> async let -> Multiple async at once, waiting for all
 
 */
//Actors are basically classes but thread Safe
//Probaly OverKill in this situation
public final class NetworkingService{
    
    public init(){
        
    }
    
    public func getJSON<T:Decodable>(url urlString:String,type:T.Type,authToken:String="")async throws -> T{

        let data = try await downloadDataFrom(url: urlString, authToken: authToken)
        return try decodeData(data: data, type: T.self)
    }
    
    
    public func downloadDataFrom(url urlString:String,authToken:String="") async throws -> Data{
        var request = try makeRequest(url: urlString) //Request
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if(!authToken.isEmpty){
            request.setValue(authToken, forHTTPHeaderField: "authToken")
        }
        
        let (data,response) = try await URLSession.shared.data(for: request)
        guard let res = response as? HTTPURLResponse else{
            throw NetworkingError.unknownError
        }
        
        //Handling Response Code
        if(!(200..<300).contains(res.statusCode)){
            Logger.logError("Bad Response: \(res.statusCode)")
            throw NetworkingError.badResponse(response: "\(res.statusCode)")
        }
        
        return data
    }
    
    
    private func makeRequest(url urlString:String)throws ->URLRequest {
        guard let url = URL(string: urlString)
        else {
            Logger.logError("Invalid URL")
            throw NetworkingError.badURL
        }
        
        return URLRequest(url: url,cachePolicy: .returnCacheDataElseLoad)
    }
    
    private func encodeData<E:Encodable>(requestData:E)throws->Data{
        let encoder = JSONEncoder()
        do{
            let encodedData = try encoder.encode(requestData)
            return encodedData
        }
        catch{
            throw NetworkingError.encodingFailed
        }
    }
    
    private func decodeData<T:Decodable>(data:Data,type:T.Type)throws->T{
        let decoder = JSONDecoder()
        do{
            
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        }
        catch{
            Logger.logError("Decoding Failed")
            throw NetworkingError.decodingFailed
        }
    }
    
    private func getPostString(params:[String:Any]) -> String{
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}
