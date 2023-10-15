//
//  RootViewModel.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 15/10/23.
//

import Foundation

class RootViewModel:ObservableObject{
    private let reachability:Reachability
    private let cacheManager:CacheManager = CacheManager.instance
    
    @Published var isNetworkConnectionAvailable:Bool = false
    
    public init(reachability: Reachability = Reachability()) {
        self.reachability = reachability
    }
    
    func checkConnection(){
        isNetworkConnectionAvailable = reachability.isConnectedToNetwork()
    }
    
    func isCacheAvailable(){
        //TODO: Check Cache...
    }
}
