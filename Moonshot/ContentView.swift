//
//  ContentView.swift
//  Moonshot
//
//  Created by Seah Park on 5/27/25.
//

import SwiftUI

struct BoxLayout: View {
    let missions: [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding(.top)
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }.padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    let missions: [Mission]
    
    var body: some View {
        Form {
            List {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.leading, 6)
                        }
                    }
                }.listStyle(.plain)
                .listRowBackground(Color.lightBackground)
            }
        }
    }
}

struct ContentView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    @State private var showingList = true
    
    var body: some View {
        ZStack {
            NavigationStack {
                Group {
                    if showingList {
                        ListLayout(missions: missions)
                    } else {
                        BoxLayout(missions: missions)
                    }
                }.navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar {
                    Button {
                        showingList.toggle()
                    } label: {
                        Text("Grid")
                        Image(systemName: "arrow.left.arrow.right")
                        Text("List")
                    }
                }
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
            }.scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
