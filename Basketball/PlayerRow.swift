//
//  PlayerRow.swift
//  Basketball
//
//  Created by Dunja on 2019/11/29.
//  Copyright © 2019 Dunja. All rights reserved.
//

import SwiftUI

struct PlayerRow: View {
    
    var player: Player
    
    var body: some View {
        HStack{
            Text(player.name)
            Spacer()
            VStack{
                Text("\(player.height) / \(player.weight) \n cm / kg")
                Text("位置：\n \(player.location)")
            }
            Text("罰球: \n \(player.exp1) 球")
            Text("二分球: \n \(player.exp2) 球")
            Text("三分球: \n \(player.exp3) 球")
            Text("比賽日期: \n \(player.born)")
            Image(systemName: player.trueHeart ? "heart.fill" : "heart")
        }
    }
}

struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRow(player: Player(name: "王怡茜", weight: 56, height: 160, exp1:1, exp2:2, exp3:3, born: "02/18/1999",  location:"小前鋒", trueHeart: true))
    }
}
