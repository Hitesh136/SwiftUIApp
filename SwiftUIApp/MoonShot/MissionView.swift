//
//  MissionView.swift
//  SwiftUIApp
//
//  Created by HITESH AGARWAL on 29/05/24.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    var crewMember: [CrewMember]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.6
                        }
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.white.opacity(0.4))
                            .padding(.vertical)
                        
                        Text("Missions HighLights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.white.opacity(0.4))
                            .padding(.vertical)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(crewMember, id: \.role) { crew in
                                NavigationLink {
                                    AstronautView(astronaut: crew.astronaut)
                                } label: {
                                    Image(crew.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay {
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(crew.astronaut.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(crew.role)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(mission: Mission, astronautDict: [String: Astronaut]) {
        self.mission = mission
        
        self.crewMember = mission.crew.map { crew in
            if let astronaut = astronautDict[crew.name] {
                return CrewMember(role: crew.role, astronaut: astronaut)
            } else {
                fatalError("Missing: \(crew.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronautDict: astronauts).preferredColorScheme(.dark)
}
