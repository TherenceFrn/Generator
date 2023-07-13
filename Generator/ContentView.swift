import SwiftUI

struct ContentView: View {
    @State private var playerName = ""
    @State private var playerList: [String] = []
    @State private var teamCount = 2
    @State private var teams: [[String]] = []
    
    @State private var showRandomNumberView = false
    
    var body: some View {
        VStack {
            Text("Générateur")
                .font(.title)
                .padding(.top, 20)
            
            HStack {
                TextField("Nouveau joueur", text: $playerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: addPlayer) {
                    Image(systemName: "plus.circle")
                }
                .padding(.trailing)
            }
            .padding(.vertical)
            
            List {
                ForEach(playerList, id: \.self) { player in
                    HStack {
                        Text(player)
                        Spacer()
                        Button(action: {
                            removePlayer(player)
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            Stepper("Nombre d'équipes: \(teamCount)", value: $teamCount, in: 2...10)
                .padding()
            
            Button(action: generateTeams) {
                Text("Générer les équipes")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if !teams.isEmpty {
                ForEach(0..<teams.count, id: \.self) { index in
                    VStack {
                        Text("Équipe \(index + 1)")
                            .font(.headline)
                            .padding(.top)
                        
                        ForEach(teams[index], id: \.self) { player in
                            Text(player)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
            
            Button(action: {
                showRandomNumberView = true
            }) {
                Text("Générateur de nombre")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showRandomNumberView) {
                RandomNumberView()
            }
            
            Spacer()
        }
        .padding()
    }
    
    func addPlayer() {
        guard !playerName.isEmpty else {
            return
        }
        
        playerList.append(playerName)
        playerName = ""
    }
    
    func removePlayer(_ player: String) {
        playerList.removeAll { $0 == player }
    }
    
    func generateTeams() {
        let shuffledPlayers = playerList.shuffled()
        let playerCount = playerList.count
        let playersPerTeam = playerCount / teamCount
        let remainingPlayers = playerCount % teamCount
        
        teams = []
        
        var startIndex = 0
        var endIndex = 0
        
        for index in 0..<teamCount {
            endIndex += playersPerTeam
            
            if index < remainingPlayers {
                endIndex += 1
            }
            
            let teamPlayers = Array(shuffledPlayers[startIndex..<endIndex])
            teams.append(teamPlayers)
            
            startIndex = endIndex
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
