//
//  ParticipantListView.swift
//  EventManage
//

import SwiftUI

struct ParticipantListView: View {
    @State private var searchText = ""
    @State private var participants: [Participant] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    TextField("Search for email", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)
                    
                    List {
                        // Populate list with RecyclerView data
                        ForEach(filteredParticipants) { participant in
                            ParticipantItemView(participant: participant)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        await loadParticipants()
                    }
                }
            }
        }
        .navigationTitle("Participants List")
        .task {
            await loadParticipants()
        }
    }
    
    var filteredParticipants: [Participant] {
        if searchText.isEmpty {
            return participants
        } else {
            return participants.filter { 
                $0.email.localizedCaseInsensitiveContains(searchText) || $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func loadParticipants() async {
        do {
            let url = URL(string: API.PARTSLIST)!
            let (data, _) = try await URLSession.shared.data(from: url)
            participants = try JSONDecoder().decode([Participant].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

#Preview {
    ParticipantListView()
}
