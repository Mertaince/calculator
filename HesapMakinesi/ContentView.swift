//
//  ContentView.swift
//  HesapMakinesi2
//
//  Created by Mert ATK on 13.05.2023.
//

import SwiftUI

enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return.orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, mutliply, divide, none
    
}



struct ContentView: View {
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
        
    ]
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation : Operation = .none
    
  
    var body: some View {
        
       
        
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
               // Text display
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                }.padding()
                
                // Our buttons
                ForEach(buttons, id: \.self){ row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self){ item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 30))
                                    .frame(width: self.buttonWidth(item: item),
                                           height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundStyle(
                                        LinearGradient(colors: [.white, .white], startPoint: .top, endPoint: .bottom))
                                    .cornerRadius(self.buttonWidth(item: item)/1)
                                    .monospacedDigit()
                            })
                        }.padding(.bottom, 3)
                            .navigationBarTitle(Text("Hesap Makinesi"))
                            
                    }
                }
                
            }
        }
        
    }
    
    func didTap(button: CalcButton){
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .mutliply{
                self.currentOperation = .mutliply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .mutliply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal{
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
    
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero{
            return (UIScreen.main.bounds.width - (5*12)) / 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.height - (5*12)) / 10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
