//
//  PlayerList.swift
//  Basketball
//
//  Created by Dunja on 2019/11/29.
//  Copyright © 2019 Dunja. All rights reserved.
//

import SwiftUI

struct PlayerList: View {
    
    @ObservedObject var playersData = PlayersData()
    @State private var showEditPlayer = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(playersData.players) { (player) in
                    NavigationLink(destination: PlayerEditor(playersData: self.playersData, editPlayer: player)){
                        PlayerRow(player: player)
                    }
                }
                .onDelete { (indexSet) in
                    self.playersData.players.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("球員列表")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                
                self.showEditPlayer = true
                
            }, label: {
                Image(systemName: "plus.circle.fill")
                
            }))
                .sheet(isPresented: $showEditPlayer) {
                    NavigationView {
                    PlayerEditor(playersData: self.playersData)
                }
            }
        }
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
        PlayerList()
    }
}
