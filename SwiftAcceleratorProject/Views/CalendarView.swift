//
//  CalendarView.swift
//  SwiftAcceleratorProject
//
//  Created by Venkatesh Devendran on 18/11/2023.
//

import SwiftUI

struct CalendarView: View {
    @State public var Events: [Event] = [
        Event(title: "Hello0", details: "Get Things done"),
        Event(title: "Hello2", details: "Finish calendar view"),
        Event(title: "Hello3", details: "Finsih The StatsView"),
        Event(title: "Hello4", details: "bye"),
    ]
    @State var DisplayEvents: [Event] = [Event(title: "", details: "")]
    @State var selectedDate: Date = Date()
    @State private var CreateNew = false
    
    var body: some View {
        NavigationStack{
            VStack() {
                Divider()
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    .padding(.horizontal)
                    .datePickerStyle(.graphical)
                Divider()
            }
            .navigationBarItems(trailing:
                                    Button{
                CreateNew = true
            }label:{
                Image(systemName: "plus.circle")
            })
            .navigationTitle("Calendar")
            List{
                Section(header: Text("Events").textCase(nil)){
                    
                    ForEach(Events.filter { x in
                        let StartDate = x.startDate
                        let EndDate = x.endDate
                        
                        let DateRange = StartDate...EndDate
                        
                        if(DateRange.contains(selectedDate)){
                            return true
                        }
                        else{
                            return false
                        }
                        
                    }, id: \.id){ itm in
                        NavigationLink(destination:{
                            EventDetailView( event: itm, Events: $Events)
                        }, label:{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(itm.title)
                                    
                                    Text(itm.details)
                                        .font(.caption)
                                }
                                
                                Spacer()
                                
                                Text("Due: \(itm.endDate, style: .time)")
                                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(10)
                            }
                        })
                        .listRowBackground(Color("lightOrange"))
                    }
                    .onDelete{Events.remove(atOffsets: $0)}
                }
                
            }
            .scrollContentBackground(.hidden)
            .toolbar(){
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $CreateNew){
                CreateNewEventView(Events: $Events, Edit: false)
            }
        }
    }
}

#Preview {
    CalendarView()
}
