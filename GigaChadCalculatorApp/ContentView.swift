//
//  ContentView.swift
//  GigaChadCalculatorApp
//
//  Created by MacBook Pro on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var numberStack: [Double] = []
    @State var operationStack: [String] = []
    @State var currentOperation: String = ""
    @State var currentNumber: String = ""
    @State var result: Double? = nil
    func DeleteOne() {
        if currentNumber != "" {
            currentNumber.removeLast()
        }
    }
    func NumberPressed(number: String) {
        if currentOperation != "" {
            currentNumber = ""
            
        }
        
        if number == "." && currentNumber.contains(".") {
            return
        }
        if currentNumber != "" {
            currentNumber += number
        } else {
            currentNumber = number
        }
        
    }
    func ConvertNumberSign () {
        if currentNumber != "" {
            if currentNumber.contains("-") {
                currentNumber.remove(at: currentNumber.startIndex)
            } else {
                currentNumber = "-" + currentNumber
            }
        }
    }
    func OperationPressed(operation: String) {
        // if there is no current number return
        if currentNumber == "" {
            return
        }
        if operation == "%" {
            if currentNumber != "" {
                currentNumber = "\(Double(currentNumber)! / 100)"
                
            }
            
        }
        
        currentOperation = operation
        if result != nil {
            numberStack = []
            operationStack = []
            numberStack.append(result!)
            operationStack.append(currentOperation)
            
            result = nil
        }
        if currentNumber != "" {
            numberStack.append(Double(currentNumber) ?? 0)
            operationStack.append(currentOperation)
            
        }
    }
    func Calculate() {
        numberStack.append(Double(currentNumber) ?? 0)
        var tempResult = numberStack[0]
        for i in 0..<operationStack.count {
            switch operationStack[i] {
            case "plus":
                tempResult += numberStack[i+1]
            case "minus":
                tempResult -= numberStack[i+1]
            case "multiply":
                tempResult *= numberStack[i+1]
            case "divide":
                tempResult /= numberStack[i+1]
            default:
                return
            }
        }
        
        result = tempResult
        Reset()
    }
    func Reset() {
        currentOperation = ""
        currentNumber = ""
    }
    func ResetAll() {
        Reset()
        numberStack = []
        operationStack = []
        result = nil
    }
    let ButtonStyleGG = (
        backgroundColor: Color.blue,
        foregroundColor: Color.white,
        cornerRadius: 10,
        padding: 20,
        fontSize: 20
    )
    var body: some View {
        ScrollView {
            HStack(alignment: .bottom){
                VStack (alignment: .trailing, spacing: 20){
                    Text(
                        result != nil ?
                        // format the result to be interger (without decimal) if possible
                        result!.truncatingRemainder(dividingBy: 1) == 0 ?
                        "\(Int(result!))" :
                            "\(result!)"
                        
                        : currentNumber != "" ? currentNumber : "0"
                        
                    )
                    .font(.system(size:90))
                    
                    .fontWeight(.light)
                    .padding()
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 10) {
                        
                        Button(action: {
                            ResetAll()
                        }) {
                            Text("AC")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(Color(UIColor.lightGray))
                                .cornerRadius(100)
                        }
                        Button(action: {
                            Reset()
                        }) {
                            Text("C")
                                .font(.title)
                            
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(Color(UIColor.lightGray))
                                .cornerRadius(60)
                        }
                        Button(action: {
                            DeleteOne()
                        }) {
                            Text(
                                
                                Image(systemName: "delete.left"))
                            .font(.title)
                            
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
                            .background(Color(UIColor.lightGray))
                            .cornerRadius(60)
                        }
                        Button(action: {
                            Calculate()
                        }) {
                            Text("=")
                                .font(.title)
                            
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(width: 70, height: 70)
                                .background(Color.orange)
                                .cornerRadius(60)
                            
                            
                        }
                        
                        ForEach([1,2,3,4,5,6,7,8,9,0], id: \.self) { i in
                            Button(action: {
                                NumberPressed(number: "\(i)")
                            }) {
                                Text("\(i)")
                                    .font(.title)
                                
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Color(UIColor.darkGray))
                                    .cornerRadius(60)
                            }
                            
                            
                        }
                        
                        ForEach(["multiply","minus","plus", "divide","percent"], id: \.self) { i in
                            Button(action: {
                                OperationPressed(operation: i)
                            }) {
                                Text(
                                    Image(systemName:
                                            i)
                                )
                                .font(.title)
                                
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(i == currentOperation ? Color.orange : Color.blue)
                                .cornerRadius(60)
                            }
                        }
                        
                        Button(action: {
                            NumberPressed(number: ".")
                        }) {
                            Text(",")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(Color.blue)
                                .cornerRadius(60)
                        }
                        Button(action: {
                            ConvertNumberSign()
                        }) {
                            Text("+/-")
                                .font(.title)
                            
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(Color.blue)
                                .cornerRadius(60)
                        }
                        
                        
                    }.padding()
                    
                    
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
