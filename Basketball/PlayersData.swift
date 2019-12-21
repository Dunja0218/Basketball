//
//  PlayersData.swift
//  Basketball
//
//  Created by Dunja on 2019/11/29.
//  Copyright © 2019 Dunja. All rights reserved.
//

import Foundation

class PlayersData: ObservableObject {
    @Published var players = [Player](){
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(players) {
                UserDefaults.standard.set(data, forKey: "players")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "players") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Player].self, from: data) {
                players = decodedData
            }
        }
    }
}
