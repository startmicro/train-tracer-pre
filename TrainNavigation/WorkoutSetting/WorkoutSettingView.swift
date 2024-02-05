//
//  WorkoutSettingView.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import HealthKit
import SwiftData
import WorkoutKit

struct WorkoutSettingView: View {
    
    //  Navigationmanager for the NavigationStack
    @EnvironmentObject var nav: NavigationStateManager
    
    //  SwiftData
    @Environment(\.modelContext) private var context
    
    @Query private var items: [DataItem]
    
    @Query private var workoutModelItem: [WorkoutModelItem]
    
    /*@Query(filter: #Predicate<WorkoutModelItem>{ $0.workoutName != ""})
        private var workoutModelItem: [WorkoutModelItem]*/
    
    //  The Goal Type --> Picker
    @State private var workoutGoalType: WorkoutGoal = .open
    @State private var availableGoalType = [WorkoutGoal]()

    @State private var workoutName: String = ""
    @State var goalValue: String = ""
    
    @State var hourDuraction: String = ""
    @State var minuteDuration: String = ""
    @State var secondDuration: String = ""
    
    var dayScheduledActivity: ActivityWithDate
    
    @State var selectedDate = Date()
    @State var selectedTime = Date()
    
    var body: some View {
        VStack(alignment: .center) {
            Text(dayScheduledActivity.activity.displayName)
                .font(.title)
            Image(systemName: dayScheduledActivity.activity.symbol)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 95))
                .foregroundColor(.blue)
                .padding()
            
            Picker("Goal", selection: $workoutGoalType) {
                            ForEach(availableGoalType) { goal in
                                Text(goal.description.capitalized)
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
                
                switch workoutGoalType {
                case .distance:
                    Text("\(workoutGoalType.description.capitalized):")
                    Spacer()
                    TextField("km", text: $goalValue)
                        .fixedSize()
                        .keyboardType(.decimalPad)
                    
                case .energy:
                    Text("\(workoutGoalType.description.capitalized):")
                    Spacer()
                    TextField("kcal", text: $goalValue)
                        .fixedSize()
                        .keyboardType(.decimalPad)
                    
                case .time:
                    Text("\(workoutGoalType.description.capitalized):")
                    Spacer()
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
                case .open: EmptyView()
                    
                @unknown default:
                    fatalError()
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
            self.selectedDate = dayScheduledActivity.activityDate
            self.availableGoalType = self.checkGoalAvailibiltyFor(activity: dayScheduledActivity.activity)
        }
    }
    
    func addItemToModel() {
        /*
        if let item = items.first(where: { $0.date == selectedDate }) {
            item.name.append(dayScheduledActivity.activity.symbol)
        } else {
            let newItem = DataItem(date: selectedDate, name: [dayScheduledActivity.activity.symbol])
            context.insert(newItem)
        }*/
        
        let exactDate = createExactDate()
        
        let newItem = WorkoutModelItem(exactDate: exactDate, workoutActivity: dayScheduledActivity.activity, workoutName: "", workoutGoalType: workoutGoalType.description)
        
        context.insert(newItem)
        
        for element in workoutModelItem {
            print("\(element.exactDate):\(element.workoutActivity.displayName)")
        }
        
    }
    
    func createExactDate() -> Date {
        // Aktuelle Kalender- und Zeitzoneinstellungen erhalten
        let calendar = Calendar.current
        //let timeZone = TimeZone.current
        
        let selectedDayDateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        //let selectedTimeDateComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
        
        let selectedTimeDateComponents = calendar.dateComponents(in: TimeZone.current, from: selectedTime)


        // Datumskomponenten erstellen
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: selectedDayDateComponents.year, month: selectedDayDateComponents.month, day: selectedDayDateComponents.day, hour: selectedTimeDateComponents.hour, minute: selectedTimeDateComponents.minute)
        
        return dateComponents.date!
    }
    
    func checkGoalAvailibiltyFor(activity: HKWorkoutActivityType) -> [WorkoutGoal]{
        
        var availableGoalType = [WorkoutGoal]()
        
        for element in WorkoutGoal.allCases {
            if(SingleGoalWorkout.supportsGoal(element, activity: activity)) {
                availableGoalType.append(element)
            }
        }
        return availableGoalType
    }
}

extension WorkoutGoal: CaseIterable {
    
    public static var allCases: [WorkoutGoal] {
        return [.open, .distance(5, .kilometers), .time(1, .hours), .energy(1000, .kilocalories)]
    }
}

extension WorkoutGoal: CustomStringConvertible {
    public var description: String {
        switch self {
        case .open: return "open"
        case .distance(_, _):
            return "distance"
        case .time(_, _):
            return "duration"
        case .energy(_, _):
            return "energy"
        @unknown default:
            return "open"
        }
    }
}

extension WorkoutGoal: Identifiable {
    public var id: Self { self }
}


#Preview {
    WorkoutSettingView(dayScheduledActivity: ActivityWithDate(activityDate: Date(), activity: .rugby))
}

