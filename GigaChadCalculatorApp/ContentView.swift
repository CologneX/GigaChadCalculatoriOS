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
        if number == "." && currentNumber.contains(".") {
            return
        }
        if currentNumber != "" {
            currentNumber += number
        } else {
            currentNumber = number
        }
        
    }
    func OperationPressed(operation: String) {
        currentOperation = operation
        if result != nil {
            numberStack = []
            operationStack = []
            numberStack.append(result!)
            operationStack.append(currentOperation)
            currentNumber = ""
            result = nil
        }
        if currentNumber != "" {
            numberStack.append(Double(currentNumber) ?? 0)
            operationStack.append(currentOperation)
            currentNumber = ""
        }
    }
    func Calculate() {
        numberStack.append(Double(currentNumber) ?? 0)
        var tempResult = numberStack[0]
        for i in 0..<operationStack.count {
            switch operationStack[i] {
            case "+":
                tempResult += numberStack[i+1]
            case "-":
                tempResult -= numberStack[i+1]
            case "X":
                tempResult *= numberStack[i+1]
            case "÷":
                tempResult /= numberStack[i+1]
            default:
                print("Error")
            }
        }
        
        result = tempResult
        Reset()
    }
    func Reset() {
        currentNumber = ""
        currentOperation = ""
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
            VStack (alignment:.trailing, spacing: 20){
                //                Text("GigaChad Calculator")
                //                    .font(.title)
                //                    .fontWeight(.bold)
                //                    .padding()
                //
                Text(
                    result != nil ?
                    
                    "\(result!)"
                    
                    : currentNumber != "" ? currentNumber : "0"
                    
                )
                .font(.system(size:40))
                
                .fontWeight(.bold)
                .padding()
                Divider()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                    Button(action: {
                        ResetAll()
                    }) {
                        Text("AC")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 80, height: 70)
                            .background(Color.red)
                            .cornerRadius(60)
                    }
                    Button(action: {
                        Reset()
                    }) {
                        Text("C")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 80, height: 70)
                            .background(Color.red)
                            .cornerRadius(60)
                    }
                    Button(action: {
                        DeleteOne()
                    }) {
                        Text(
                            
                            Image(systemName: "delete.left"))
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 80, height: 70)
                        .background(Color.red)
                        .cornerRadius(60)
                    }
                    ForEach([1,2,3,4,5,6,7,8,9,0], id: \.self) { i in
                        Button(action: {
                            NumberPressed(number: "\(i)")
                        }) {
                            Text("\(i)")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 80, height: 70)
                                .background(Color.gray)
                                .cornerRadius(60)
                        }
                        
                        
                    }
                    
                    ForEach(["X", "÷", "+", "-"], id: \.self) { i in
                        Button(action: {
                            OperationPressed(operation: i)
                        }) {
                            Text("\(i)")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 80, height: 70)
                                .background(i == currentOperation ? Color.green : Color.blue)
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
                            .frame(width: 80, height: 70)
                            .background(Color.blue)
                            .cornerRadius(60)
                    }
                    
                }
                Button(action: {
                    Calculate()
                }) {
                    Text("=")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(Color.blue)
                        .cornerRadius(60)
                    
                    
                }
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 20,
                        bottom: 0,
                        trailing: 20
                    )
                )
                
            }
        }
    }
}

#Preview {
    ContentView()
}
