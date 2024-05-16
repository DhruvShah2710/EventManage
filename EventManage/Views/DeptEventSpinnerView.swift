//
//  DeptEventSpinnerView.swift
//  EventManage
//

import SwiftUI

struct DeptSpinnerView: View {
    @Binding var selectedDept: String
    
    var body: some View {
        Picker("Select Department", selection: $selectedDept) {
            ForEach(Department.allCases, id: \.self) { department in
                Text(department.rawValue).tag(department.rawValue)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .frame(width: 300, height: 45)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.top, 10)
        .foregroundColor(.black)
    }
}

struct DeptEventSpinnerView: View {
    @Binding var selectedDept: Department
    @Binding var selectedEvent: Event
    @State private var events: [Event] = Department.computer.events
    
    var body: some View {
        VStack {
            Picker("Select Department", selection: $selectedDept.onChange(updateEvents)) {
                ForEach(Department.allCases, id: \.self) { department in
                    Text(department.rawValue).tag(department.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 300, height: 45)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.top, 10)
            .foregroundColor(.black)
            
            if !events.isEmpty {
                Picker("Select Event", selection: $selectedEvent) {
                    ForEach(events, id: \.self) { event in
                        Text(event.name).tag(event.code)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 300, height: 45)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.top, 10)
                .foregroundColor(.black)
            }
        }
    }
    
    private func updateEvents(_ department: Department) {
        events = department.events
        selectedEvent=events[0]
    }
}
