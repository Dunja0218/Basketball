//
//  PlayerEditor.swift
//  Basketball
//
//  Created by Dunja on 2019/11/29.
//  Copyright © 2019 Dunja. All rights reserved.
//

import SwiftUI

struct PlayerEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var playersData: PlayersData
    var editPlayer: Player?
    @State private var showPieChart = false
    
    @State private var selectDate = Date()
    let today = Date()
    let startDate = Calendar.current.date(byAdding: .year, value: -50, to: Date())!
    var year: Int {
        Calendar.current.component(.year, from: selectDate)
    }
    let dateValue = DateFormatter()
    @State private var trueHeart = true
    @State private var name = ""
    @State private var weight = 50
    @State private var height = 160
    @State private var exp1 = 1
    @State private var exp2 = 2
    @State private var exp3 = 3
    @State private var born = ""
    @State private var location = ""
    var roles = ["控球後衛", "得分後衛", "小前鋒", "大前鋒", "中鋒"]
    @State private var selectedIndex = 0
    
    var body: some View {
        Form {
            TextField("名字", text: $name)
            Stepper("身高 \(height) cm", value: $height, in: 100...200)
            Stepper("體重 \(weight) kg", value: $weight, in: 30...100)
            DatePicker("比賽日期", selection: self.$selectDate, in: self.startDate...self.today, displayedComponents: .date)
            Toggle("先發", isOn: $trueHeart)
            Stepper("罰球 \(exp1) 球", value: $exp1, in: 0...100)
            Stepper("二分球 \(exp2) 球", value: $exp2, in: 0...100)
            Stepper("三分球 \(exp3) 球", value: $exp3, in: 0...100)
            
            Picker(selection: self.$selectedIndex, label: Text("位置")) {
                Text(self.roles[0]).tag(0)
                Text(self.roles[1]).tag(1)
                Text(self.roles[2]).tag(2)
                Text(self.roles[3]).tag(3)
                Text(self.roles[4]).tag(4)
            }.pickerStyle(WheelPickerStyle())
                .frame(width: 400, height: 200)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
                .shadow(radius: 30)
            
                Text("顯示得分比例")
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .cornerRadius(30)
                    .onTapGesture {
                        self.showPieChart = true
                }.sheet(isPresented: $showPieChart) {
                    GameAnalysis(one: self.$exp1, two: self.$exp2, three: self.$exp3)
                }
        }
        .navigationBarTitle(editPlayer == nil ?  "Add new player" : "Edit player")
        .navigationBarItems(trailing: Button("Save"){
            self.dateValue.dateFormat = "MM/dd/yyyy"
            let player = Player(name: self.name, weight: self.weight, height: self.height, exp1: self.exp1, exp2: self.exp2, exp3: self.exp3,  born: self.dateValue.string(from: self.selectDate) , location: self.roles[self.selectedIndex], trueHeart: self.trueHeart)
            if let editPlayer = self.editPlayer {
                let index = self.playersData.players.firstIndex {
                    $0.id == editPlayer.id
                    }!
                self.playersData.players[index] = player
            }
            else {
                self.playersData.players.insert(player, at: 0)
            }
            self.presentationMode.wrappedValue.dismiss()
        })
            .onAppear {
                if let editPlayer = self.editPlayer {
                    self.name = editPlayer.name
                    self.weight = editPlayer.weight
                    self.trueHeart = editPlayer.trueHeart
                    self.height = editPlayer.height
                    self.exp1 = editPlayer.exp1
                    self.exp2 = editPlayer.exp2
                    self.exp3 = editPlayer.exp3
                    self.born = editPlayer.born
                    self.location = editPlayer.location
                }
        }
    }
}

struct PlayerEditor_Previews: PreviewProvider {
    static var previews: some View {
        PlayerEditor(playersData: PlayersData())
    }
}
