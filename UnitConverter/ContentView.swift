//
//  ContentView.swift
//  UnitConverter
//
//  Created by Antarcticaman on 17/6/2564 BE.
//

import SwiftUI

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f",self) : String(format: "%.6f",self)
    }
}

enum UnitLabel: String {
    case meters = "m"
    case millimeters = "mm"
    case kilometers = "km"
    case inches = "in"
    case feet = "ft"
    case miles = "mi"
}

struct ContentView: View {
    
    @State private var selectedInputUnit = 2
    @State private var selectedOutputUnit = 5
    @State private var inputAmount = ""
    var lengthUnits: [UnitLabel] = [.millimeters,.meters,.kilometers,.inches,.feet,.miles]
    
    var outputValue: Double {
        let inputValue = Double(inputAmount) ?? 0
        let inputUnit = lengthUnits[selectedInputUnit]
        let outputUnit = lengthUnits[selectedOutputUnit]
        let inputResultInMM: Double = calculateInputInMM(inputValue, inputUnit)
        
        return calculateOutput(to: outputUnit, inputResultInMM)
    }
    
    private func calculateInputInMM(_ inputValue: Double, _ inputUnit: UnitLabel) -> Double {
        switch inputUnit {
        case .millimeters :
            return inputValue
        case .meters :
            return inputValue * 1000
        case .kilometers:
            return inputValue * 1_000_000
        case .inches:
            return inputValue * 25.4
        case .feet:
            return inputValue * 304.8
        case .miles:
            return inputValue * 1_609_344
        }
    }
    
    private func calculateOutput(to outputUnit: UnitLabel, _ inputResultInMM: Double ) -> Double {
        switch outputUnit {
        case .millimeters:
            return inputResultInMM
        case .meters:
            return inputResultInMM / 1000
        case .kilometers:
            return inputResultInMM / 1_000_000
        case .inches:
            return inputResultInMM / 25.4
        case .feet:
            return inputResultInMM / 304.8
        case .miles:
            return inputResultInMM / 1_609_344
        }
    }
    
    private func unitLabel(of selectedUnit: Int) -> String {
        let unitSymbol = lengthUnits[selectedUnit]
        switch unitSymbol {
        case .millimeters:
            return "Milimeters"
        case .meters:
            return "Meters"
        case .kilometers:
            return "Kilometers"
        case .inches:
            return "Inches"
        case .feet:
            return "Feet"
        case .miles:
            return "Miles"
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input Unit")) {
                    Picker("Select the Unit", selection: $selectedInputUnit) {
                        ForEach(0..<lengthUnits.count) {
                            Text("\(self.lengthUnits[$0].rawValue)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("Input Amount", text: $inputAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Convert to")) {
                    Picker("Select the Unit", selection: $selectedOutputUnit) {
                        ForEach(0..<lengthUnits.count) {
                            Text("\(self.lengthUnits[$0].rawValue)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("\(inputAmount) \(unitLabel(of: selectedInputUnit)) =")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(outputValue.clean) \(unitLabel(of: selectedOutputUnit))")
                        .font(.title)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
            .navigationBarTitle("Length Converter")
        }
    }
    
    init() {
           //Use this if NavigationBarTitle is with Large Font
           UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
       }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}


