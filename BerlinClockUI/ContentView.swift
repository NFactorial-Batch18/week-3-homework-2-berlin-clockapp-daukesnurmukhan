//
//  ContentView.swift
//  BerlinClockUI
//
//  Created by Нұрмұхан Дәукес on 11.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State var hours = 0
    @State var minutes = 0
    @State var allLamps = Array(repeating: false, count: 24)
    var body: some View {


    ZStack {
        Color(red: 242/255, green: 242/255, blue: 238/255)
            .ignoresSafeArea()
    
    VStack {
        Text("Time is \(hours):\(minutes)")
            .frame(width: 130, height: 22, alignment: .center)
            .font(.system(size: 17, weight: .semibold))
            .padding(.top, 28)
            .padding(.bottom, 20)
            
    
        ZStack {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: 358, height: 312, alignment: .center)
            .foregroundColor(.white)
            .padding(.bottom, 10)
            VStack {
            Circle()
                .frame(width: 56, height: 56, alignment: .center)
                .foregroundColor(Color(red: 255/255, green: 204/255, blue: 0/255, opacity: 1))
                .padding(.top, 32)
                //.padding(.bottom, 16)
                
                HStack {
                    FiveHoursRectangle(isOn: $allLamps[1])
                    FiveHoursRectangle(isOn: $allLamps[2])
                    FiveHoursRectangle(isOn: $allLamps[3])
                    FiveHoursRectangle(isOn: $allLamps[4])
                }
                .padding(.bottom, 16)
                
                HStack {
                    OneHoursRectangle(isOn: $allLamps[5])
                    OneHoursRectangle(isOn: $allLamps[6])
                    OneHoursRectangle(isOn: $allLamps[7])
                    OneHoursRectangle(isOn: $allLamps[8])
                }
                .padding(.bottom, 16)
                
                HStack {
                    Group {
                        FiveMinuteYellowRectangle(isOn: $allLamps[9])
                        FiveMinuteYellowRectangle(isOn: $allLamps[10])
                        FiveMinuteRedRectangle(isOn: $allLamps[11])
                        FiveMinuteYellowRectangle(isOn: $allLamps[12])
                        FiveMinuteYellowRectangle(isOn: $allLamps[13])
                        FiveMinuteRedRectangle(isOn: $allLamps[14])
                        FiveMinuteYellowRectangle(isOn: $allLamps[15])
                        FiveMinuteYellowRectangle(isOn: $allLamps[16])
                        FiveMinuteRedRectangle(isOn: $allLamps[17])
                        FiveMinuteYellowRectangle(isOn: $allLamps[18])
                    }
                    FiveMinuteYellowRectangle(isOn: $allLamps[19])
                }
                .padding(.bottom, 16)
                
                HStack {
                    OneMinuteRectangle(isOn: $allLamps[20])
                    OneMinuteRectangle(isOn: $allLamps[21])
                    OneMinuteRectangle(isOn: $allLamps[22])
                    OneMinuteRectangle(isOn: $allLamps[23])

                }
                
                .padding(.bottom, 32)
                
            }
        }
        
        
        ZStack {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 358, height: 54)
            .foregroundColor(.white)
            
            
            Time(time: $selectedDate).onChange(of: selectedDate) { _
                in
                putTime()
                changeHours(hours: hours)
                changeMinutes(minutes: minutes)
            }
            
        }
        Spacer()
    }
        
        
        
        
 }
}
    //putTime
    func putTime(){
        allLamps = Array(repeating: false, count: 24)
        let components = Calendar.current.dateComponents([.hour, .minute], from: selectedDate)
        hours = components.hour ?? 0
        minutes = components.minute ?? 0
    }
   
    
    func changeHours(hours: Int) {
        var bulb = 0
        if hours > 4{
            bulb = hours / 5
            for i in Range(1...bulb){
                allLamps[i] = true
            }
        }
        bulb = hours % 5
        if bulb > 0{
            for i in Range(5...bulb + 4){
                allLamps[i] = true
            }
        }
    }
    
    func changeMinutes(minutes: Int) {
        var bulb = 0
        if minutes > 4 {
            bulb = minutes / 5
            for i in Range(9...bulb + 8){
                allLamps[i] = true
            }
        }
        bulb = minutes % 5
        if bulb > 0{
            for i in Range(20...bulb + 19){
                allLamps[i] = true
            }
        }
    }
}

struct Time: View {
    @Binding var time: Date
  var body: some View {
      DatePicker(selection: $time, displayedComponents:.hourAndMinute){
      Text("Insert time")
              .frame(width: 120, height: 24, alignment: .leading)
              .font(.system(size: 18, weight: .medium))
      }
      .frame(width: 340, height: 50)
      .environment(\.locale, Locale(identifier: "ru_RU"))
    }
}

struct FiveHoursRectangle: View {
    @Binding var isOn: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 74, height: 32)
            .foregroundColor(isOn ? Color(red: 255/255, green: 59/255, blue: 48/255, opacity: 1) : Color(red: 255/255, green: 137/255, blue: 131/255, opacity: 1))
    }
}

struct OneHoursRectangle: View {
    @Binding var isOn: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 74, height: 32)
            .foregroundColor(isOn ? Color(red: 255/255, green: 59/255, blue: 48/255, opacity: 1) : Color(red: 255/255, green: 137/255, blue: 131/255, opacity: 1))
    }
}

struct FiveMinuteYellowRectangle: View {
    @Binding var isOn: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 21, height: 32)
            .foregroundColor(isOn ? Color(red: 255/255, green: 204/255, blue: 0/255, opacity: 1) : Color(red: 255/255, green: 224/255, blue: 102/255, opacity: 1))
    }
}

struct FiveMinuteRedRectangle: View {
    @Binding var isOn: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 21, height: 32)
            .foregroundColor(isOn ? Color(red: 255/255, green: 59/255, blue: 48/255, opacity: 1) : Color(red: 255/255, green: 137/255, blue: 131/255, opacity: 1))
    }
}

struct OneMinuteRectangle: View {
    @Binding var isOn: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 74, height: 32)
            .foregroundColor(isOn ? Color(red: 255/255, green: 204/255, blue: 0/255, opacity: 1) : Color(red: 255/255, green: 224/255, blue: 102/255, opacity: 1))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



