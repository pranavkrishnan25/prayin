//
//  EventListView.swift
//  notbs
//
//  Created by Pranav Krishnan on 8/19/23.
//

import SwiftUI


struct EventsListView: View {
    @ObservedObject var eventVM: EventViewModel
    @State private var searchQuery: String = ""
    
    var filteredEvents: [Event] {
        eventVM.events.filter {
            searchQuery.isEmpty ||
            $0.group.localizedCaseInsensitiveContains(searchQuery) ||
            $0.type.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    var body: some View {
        VStack {
            // Search TextField
            TextField("Search events...", text: $searchQuery)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            // Refresh Button
            Button(action: {
                eventVM.fetchData() // This assumes your EventViewModel has a fetchData method.
            }) {
                Image(systemName: "arrow.clockwise") // Using SF Symbol for refresh. You can change this.
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            // Events List
            List(filteredEvents, id: \.date) { event in
                VStack(alignment: .leading) {
                    Text(event.group)
                        .font(.headline)
                    Text(event.type)
                        .font(.subheadline)
                    Text("\(event.date)")
                        .font(.caption)
                }
            }
        }
    }
}
