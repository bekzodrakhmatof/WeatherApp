//
//  ContentView.swift
//  WeatherApp
//
//  Created by Aiden Choi on 2022/01/27.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = self.locationManager.location {
                if let weather = self.weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                self.weather = try await self.weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather data: ", error)
                            }
                        }
                }
            } else {
                if self.locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(self.locationManager)
                }
            }
        }
        .background(Color.indigo)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
