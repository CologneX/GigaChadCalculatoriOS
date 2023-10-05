import SwiftUI

struct ContentView: View {
    @State private var currentInput: String = "0"
    @State private var numbers: [Double] = []
    @State private var operators: [String] = []
    @State private var currentOperator: String? = nil
    @State var displayedNumber: String? = nil
    
    let operationButtons = [
        "+", "-", "×", "÷", "%", ".", "+/-", "="
    ]
    
    var clearButtonLabel: String {
        if currentInput == "0" {
            return "AC"
        } else {
            return "C"
        }
    }
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .trailing, spacing: 20){
                Text(
                    (displayedNumber != nil && currentInput == "0") ? displayedNumber! : currentInput
                )
                .font(.system(size:90))
                .padding()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 10) {
                    Button(action: {
                        handleButtonTap(clearButtonLabel)
                    }) {
                        Text(clearButtonLabel)
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: 70, height: 70)
                            .background(Color(UIColor.lightGray))
                            .cornerRadius(100)
                    }
                    
                    Button(action: {
                        handleButtonTap("⌫")
                    }) {
                        Text(Image(systemName: "delete.left"))
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: 70, height: 70)
                            .background(Color(UIColor.lightGray))
                            .cornerRadius(60)
                    }
                    
                    ForEach([1,2,3,4,5,6,7,8,9,0], id: \.self) { i in
                        Button(action: {
                            handleButtonTap(String(i))
                        }) {
                            Text("\(i)")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(Color(UIColor.darkGray))
                                .cornerRadius(60)
                        }
                    }
                    
                    ForEach(operationButtons, id: \.self) { operation in
                        Button(action: {
                            handleButtonTap(operation)
                        }) {
                            Text(operation)
                                .font(.title)
                                .foregroundColor(buttonForegroundColor(operation))
                                .frame(width: 70, height: 70)
                                .background(buttonBackgroundColor(operation))
                                .cornerRadius(60)
                        }
                    }
                }.padding()
            }
            
        }
    }
    
    func buttonForegroundColor(_ button: String) -> Color {
        return button == currentOperator ? Color.orange : Color.white
    }
    
    func buttonBackgroundColor(_ button: String) -> Color {
        return button == currentOperator ? Color.white : Color.orange
    }
    
    func handleButtonTap(_ button: String) {
        switch button {
        case "AC":
            currentInput = "0"
            currentOperator = nil
            displayedNumber = nil
            numbers.removeAll()
            operators.removeAll()
        case "C":
            currentInput = "0"
            displayedNumber = nil
        case "⌫":
            if currentInput.count > 1 {
                currentInput.removeLast()
            } else {
                currentInput = "0"
            }
        case "+", "-", "×", "÷":
            if currentInput == "0" && numbers.isEmpty {
                return
            }
            if currentInput != "Error" {
                numbers.append(Double(currentInput) ?? 0)
                operators.append(button)
                displayedNumber = currentInput
                currentInput = "0"
                currentOperator = button
            }
        case "%":
            if  currentInput != "Error"{
                let decimalPercentage = Double(currentInput)! / 100
                if !numbers.isEmpty {
                    let lastNumber = numbers.last!
                    let result = lastNumber * decimalPercentage
                    currentInput = result.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(result))" : "\(result)"
                }  else {
                    
                    currentInput = decimalPercentage.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(decimalPercentage))" : "\(decimalPercentage)"
                }
                
            }
            
        case "=":
            if currentInput != "Error" && currentOperator != nil {
                numbers.append(Double(currentInput) ?? 0)
                currentInput = calculateResult()
                displayedNumber = nil
                numbers.removeAll()
                operators.removeAll()
                currentOperator = nil
            }
        case "+/-":
            if currentInput != "0" && currentInput != "Error" {
                if currentInput.hasPrefix("-") {
                    currentInput.remove(at: currentInput.startIndex)
                } else {
                    currentInput = "-" + currentInput
                }
            }
        case ".":
            if currentInput != "Error" && !currentInput.contains(".") {
                currentInput += "."
            }
        default:
            if currentInput == "0" || currentInput == "Error" {
                currentInput = button
            } else {
                currentInput += button
                
            }
        }
    }
    
    func calculateResult() -> String {
        var result = numbers[0]
        for (index, operatorChar) in operators.enumerated() {
            let operand = numbers[index + 1]
            
            switch operatorChar {
            case "+":
                result += operand
            case "-":
                result -= operand
            case "×":
                result *= operand
            case "÷":
                if operand == 0 {
                    return "Error"
                }
                result /= operand
            case "%":
                result /= 100
            default:
                break
            }
        }
        print(numbers)
        print(operators)
        return result.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(result))" : "\(result)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
