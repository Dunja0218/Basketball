//
//  GameAnalysis.swift
//  Basketball
//
//  Created by Dunja on 2019/12/19.
//  Copyright © 2019 Dunja. All rights reserved.
//

import SwiftUI

struct GameAnalysis: View {
    
    @Binding var one:Int
    @Binding var two:Int
    @Binding var three:Int
    var body: some View {
        VStack {
            Text("得分比例")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
            
            PieChartView(percentages: [Double(100*one*1/(one*1+two*2+three*3)), Double(100*two*2/(one*1+two*2+three*3)), Double(100*three*3/(one*1+two*2+three*3))])
                          .frame(width: 200, height: 200)
            
            Text("總得分: \(NSString(format: "%.2d", (one*1+two*2+three*3)))分")
            HStack{
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 20, height: 20)
                Text("罰球")
                Circle()
                    .fill(Color.green)
                    .frame(width: 20, height: 20)
                Text("二分球")
                Circle()
                    .fill(Color.red)
                    .frame(width: 20, height: 20)
                Text("三分球")
            }
        }
    }
}

struct GameAnalysis_Previews: PreviewProvider {
    static var previews: some View {
        GameAnalysis(one: .constant(6), two: .constant(3), three: .constant(6))
    }
}
