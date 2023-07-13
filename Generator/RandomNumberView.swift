//
//  RandomNumberView.swift
//  Generator
//
//  Created by Thérence FERRON on 7/13/23.
//

import SwiftUI

struct RandomNumberView: View {
    @State private var maxValue = 1
    @State private var randomNumber = 1
    
    var body: some View {
        VStack {
            Text("Générateur de nombre aléatoire")
                .font(.title)
                .padding(.top, 20)
            
            Stepper("Valeur maximale: \(maxValue)", value: $maxValue, in: 1...100)
                .padding()
            
            Text("Nombre aléatoire généré: \(randomNumber)")
                .font(.headline)
            
            Button(action: generateRandomNumber) {
                Text("Générer")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func generateRandomNumber() {
        randomNumber = Int.random(in: 1...maxValue)
    }
}

