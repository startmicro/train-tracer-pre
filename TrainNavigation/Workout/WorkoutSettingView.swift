//
//  WorkoutSettingView.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import HealthKit
import SwiftData

struct WorkoutSettingView: View {
    
    @EnvironmentObject var nav: NavigationStateManager
    @Environment(\.modelContext) private var context
    
    @Query private var items: [DataItem]
    
    enum Goal: String, CaseIterable, Identifiable {
        case duration, distance, energy
        var id: Self { self }
    }
    @State private var goal: Goal = .duration
    @State private var workoutName: String = ""
    @State var goalValue: String = ""
    
    @State var hourDuraction: String = ""
    @State var minuteDuration: String = ""
    @State var secondDuration: String = ""
    
    var activityWithDate: ActivityWithDate
    
    @State var selectedDate = Date()
    @State var selectedTime = Date()
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text(activityWithDate.activity.displayName)
                .font(.title)
            Image(systemName: activityWithDate.activity.symbol)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 95))
                .foregroundColor(.blue)
                .padding()
            
            Picker("Goal", selection: $goal) {
                            ForEach(Goal.allCases) { goal in
                                Text(goal.rawValue.capitalized)
                            }
                        }
                    .pickerStyle(.segmented)
                    .padding()
            TextField("Enter your Workout name", text: $workoutName)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Text("Workout Date:")
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    .fixedSize()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            HStack {
                Text("Workout Time:")
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    .fixedSize()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            HStack{
                Text("\(goal.rawValue.capitalized):")
                Spacer()
                switch goal {
                case .distance:
                    TextField("km", text: $goalValue)
                        .fixedSize()
                        .keyboardType(.decimalPad)
                    
                case .energy:
                    TextField("kcal", text: $goalValue)
                        .fixedSize()
                        .keyboardType(.decimalPad)
                    
                case .duration:
                    HStack {
                        TextField("HH", text: $hourDuraction)
                            .fixedSize()
                            .keyboardType(.decimalPad)
                        Text(":")
                        TextField("MM", text: $minuteDuration)
                            .fixedSize()
                            .keyboardType(.decimalPad)
                        Text(":")
                        TextField("SS", text: $secondDuration)
                            .fixedSize()
                            .keyboardType(.decimalPad)
                    }
                }
            }
            Button("Save"){
                self.addItemToModel()
                nav.popToRoot()
            
            }.padding()
                .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .modifier(NavigationBackButton())
        .padding()
        .onAppear() {
            self.selectedDate = activityWithDate.activityDate
            
        }
    }
    
    func addItemToModel() {
        print("addItemToModel")
        if let item = items.first(where: { $0.date == selectedDate }) {
            print("item vorhanden at: \(selectedDate)")
            item.name.append(activityWithDate.activity.symbol)
        } else {
            print("kein item vorhanden")
            print("try to create item at: \(selectedDate) for activity: \(activityWithDate.activity.symbol)")
            let newItem = DataItem(date: selectedDate, name: [activityWithDate.activity.symbol])
            print("item created: \(newItem)")
            context.insert(newItem)
            print("item inserted")
        }
    
    }
}

#Preview {
    WorkoutSettingView(activityWithDate: ActivityWithDate(activityDate: Date(), activity: .rugby))
}

