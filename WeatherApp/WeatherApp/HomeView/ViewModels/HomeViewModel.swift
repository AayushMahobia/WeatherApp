//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Admin on 29/01/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    var weatherData: Welcome?
    @Published var isLoading = false
    @Published var errorMessage: String?

    // Replace with your API URL
    private let apiURL = "https://api.openweathermap.org/data/2.5/forecast?lat=21.199560&lon=81.289009&appid=5efdf56a62515d122d48355a620dbdd4"
    
    // Fetch weather data from API
    func fetchWeatherData() async {
        guard let url = URL(string: apiURL) else {
            self.errorMessage = "Invalid URL"
            print(self.errorMessage ?? "some error (url)")
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
            self.weatherData = decodedData

        } catch {
            self.errorMessage = "Error: \(error.localizedDescription)"
            print(self.errorMessage ?? "some error (data)")
        }

        await MainActor.run {
            isLoading = false
        }
    }
    
    
    // Helper Function
    func getCityName() -> String {
        weatherData?.city.name ?? "N/A"
    }

    func kelvinToCelsius(_ kelvin: Double) -> Double {
        return kelvin - 273.15
    }
    
    func formatDecimal(_ decimal: Double) -> String {
        return String(format: "%.f", decimal)
    }
    
    func getCurrentTemperature() -> String {
        guard let temp = weatherData?.list.first?.main.temp else { return "N/A" }
        return "\(formatDecimal(kelvinToCelsius(temp)))°"
    }
    
    func getImageURL(_ iconID: String) -> URL! {
        let imageURLString = "https://openweathermap.org/img/wn/\(iconID)@2x.png"
        return URL(string: imageURLString)
    }
    
    func formatDate(_ dateString: String, inputFormat: String, outputFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat

        guard let date = inputFormatter.date(from: dateString) else {
            return ""
        }
        
        return outputFormatter.string(from: date)
    }
}
