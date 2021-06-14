//
//  ContentView.swift
//  Calculator
//
//  Created by Asadulla Juraev on 14.06.2021.
//  If you want may you change dark to light mode.

import SwiftUI

enum Buttons: String {
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
    case multiply = "x"
    case equal = "="
    case clear = "C"
    case decimal = "."
    
    var numBGColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide:
            return Color("b_arif_bg")
        case .clear:
            return Color("b_clear")
        case .equal:
            return Color("b_equal")
        default:
            return Color("b_bg")
        }
    }
    
    var numColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return Color("b_arif_font")
        case .clear:
            return Color("b_clear_font")
        default:
            return Color("b_font")
        }
    }
}

enum Operations {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var typingNumber: Double = 0.0
    @State var currentOperation: Operations = .none
    
    let buttons: [[Buttons]] = [
        [.clear, .divide, .multiply],
        [.seven, .eight, .nine, .subtract],
        [.four, .five, .six, .add],
        [.one, .two, .three, .decimal],
        [.zero, .equal]
    ]
    
    var body: some View {
        ZStack{
            
            Color("bg").edgesIgnoringSafeArea(.all)
            
            VStack{
                
                //Display text
                HStack{
                    Spacer()
                    Text(value)
                    .bold()
                    .font(.system(size: 52))
                }.padding()
                .padding(.top, 20)
                
                //Buttons
                Spacer()
                ForEach(buttons, id: \.self) { row in
                    HStack{
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }){
                                Text(item.rawValue)
                                    .fontWeight(.bold)
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .font(.system(size: 30))
                                    .background(item.numBGColor)
                                    .foregroundColor(item.numColor)
                                    .cornerRadius(25)
                            }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: Buttons){
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.typingNumber = Double(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.typingNumber = Double(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.typingNumber = Double(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.typingNumber = Double(self.value) ?? 0
            }
            else if button == .equal{
                let typingValue = self.typingNumber
                let currentValue = Double(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(typingValue + currentValue)"
                    let n = Double(self.value)
                    let r = n.map{ return Int(exactly: $0) == nil ?  "\($0)" : "\(Int($0))" }
                    self.value = "\(r!)"
                case .subtract:
                    self.value = "\(typingValue - currentValue)"
                    let n = Double(self.value)
                    let r = n.map{ return Int(exactly: $0) == nil ?  "\($0)" : "\(Int($0))" }
                    self.value = "\(r!)"
                case .divide:
                    self.value = "\(typingValue / currentValue)"
                    let n = Double(self.value)
                    let r = n.map{ return Int(exactly: $0) == nil ?  "\($0)" : "\(Int($0))" }
                    self.value = "\(r!)"
                case .multiply:
                    self.value = "\(typingValue * currentValue)"
                    let n = Double(self.value)
                    let r = n.map{ return Int(exactly: $0) == nil ?  "\($0)" : "\(Int($0))" }
                    self.value = "\(r!)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
            
        case .decimal:
            let num = button.rawValue
            if self.value == "0" || self.value != "0" {
                value = "\(self.value)\(num)"
            }
            
        default:
            let num = button.rawValue
            if self.value == "0"{
                value = num
            }
            else {
                self.value = "\(self.value)\(num)"
            }
        }
    }
    
    func buttonWidth(item: Buttons) -> CGFloat {
        let width = ((UIScreen.main.bounds.width - (4*12)) / 4)
        if item == .zero || item == .equal || item == .clear {
            return width * 2.1
        }
        return width
    }
    func buttonHeight() -> CGFloat {
        let height = (UIScreen.main.bounds.width - (5*12)) / 4
        if height >= 150 {
            return 150
        }
        return height
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
