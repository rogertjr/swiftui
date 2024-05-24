//
//  ControlsView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 24/05/24.
//

import SwiftUI

struct ControlsView: View {
    // MARK: - Properties
    private enum Option: String, CaseIterable {
        case x,y,z
    }
    
    @State private var selectedOption = Option.x
    @State private var rating = 8.0
    @State private var percentage: Double = 25
    @State private var age = 18
    @State private var birthday = Date()
    @State private var hour = Date()
    @State private var toggleStatus: Bool = true
    @State private var selectedColor: Color = .red
    
    // MARK: - UI Elements
    var body: some View {
        Form {
            stepperSection
            sliderSection
            toggleSection
            colorPickerSection
            datePickerSection
            pickerSection
        }
        .navigationTitle("Controls")
        .scrollContentBackground(.hidden)
    }
}

private extension ControlsView {
    func pickerView(_ title: String) -> some View {
        Picker("Options", selection: $selectedOption) {
            ForEach(Option.allCases, id: \.self) {
                Text($0.rawValue.capitalized).tag($0)
            }
        }
    }
    
    var datePickerView: some View {
        DatePicker("Enter your birthday",
                   selection: $birthday,
                   in: ...Date.now,
                   displayedComponents: .date)
    }
    
    var sliderSection: some View {
        Section("Slider") {
            HStack {
                Text("Selected Value ")
                + Text(String(format: "%.2f %", percentage))
                    .bold()
            }
            
            Slider(value: $percentage, in: 0...100,
                   minimumValueLabel: Text("0%"),
                   maximumValueLabel: Text("100%"),
                   label: { Text("Percentage") })
            
            HStack {
                Text("Rating ")
                + Text(String(format: "%.0f", rating))
                    .bold()
            }
            
            Slider(value: $rating, in: 1...10,
                   step: 1,
                   minimumValueLabel: Text("0"),
                   maximumValueLabel: Text("10"),
                   label: { Text("Rating") })
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    var toggleSection: some View {
        Section("Toggle") {
            Toggle(isOn: $toggleStatus, label: {
                Text("Is On?")
                + Text(" \(toggleStatus)").bold()
            })
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    var colorPickerSection: some View {
        Section("Color Picker") {
            ColorPicker(selection: $selectedColor, label: {
                Text("Select a color")
            })
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    var datePickerSection: some View {
        Section("DatePicker") {
            Text("Hour and Minute").bold()
            DatePicker("Select hour",
                       selection: $hour,
                       displayedComponents: .hourAndMinute)
            
            Text("Compact Style").bold()
            datePickerView
                .datePickerStyle(.compact)
            
            Text("Graphical Style").bold()
            datePickerView
                .datePickerStyle(.graphical)
            
            Text("Wheel Style").bold()
            datePickerView
                .datePickerStyle(.wheel)
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    var stepperSection: some View {
        Section("Stepper") {
            HStack {
                Text("Value Selected")
                + Text(" \(age)")
                    .bold()
            }
            Stepper("Enter your age", value: $age, in: 0...100)
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    var pickerSection: some View {
        Section("Pickers") {
            Text("Segmented Style").bold()
            pickerView("Segmented picker example")
                .pickerStyle(.segmented)
            
            Text("Menu Style").bold()
            pickerView("Options")
                .pickerStyle(.menu)
            
            Text("Wheel Style").bold()
            pickerView("Options")
                .pickerStyle(.wheel)
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ControlsView()
    }
}
