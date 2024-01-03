//
//  ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var milesBiked: Double?
    @State private var isAuthorized = false
    
    let healthKitManager = HealthKitManager()
    
    var body: some View {
        VStack {
            Text("🚴‍♀️") // Bike emoji
                .font(.largeTitle)
            if isAuthorized {
                Text("Miles Biked: \(milesBiked ?? 0)")
            }
        }
        .onAppear() {
            fetchMilesBiked()
        }
        .padding()
    }
    
    func fetchMilesBiked() {
        print("fetch step count")
        print("requesting Authorization")
        healthKitManager.requestAuthorization { success, error in
            if success {
                self.isAuthorized = true
            } else {
                print("Authorization error")
                print(error)
            }
        }
        
        healthKitManager.fetchMilesBiked { miles, error in
            print(miles)
            self.milesBiked = miles
            print(error)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

