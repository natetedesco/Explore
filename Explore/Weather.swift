
import Foundation
import MapKit
import WeatherKit

@Observable class Weather {
    var location: Location?
    var weatherForecast: Forecast<DayWeather>?
    
    var sunriseTime: Date?
    var sunsetTime: Date?
    var todayTemp: Int?
    
    func fetchWeatherData(for location: Location) {
        Task {
            do {
                let service = WeatherService()
                let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                
                let forecast = try await service.weather(for: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude), including: .daily)
                DispatchQueue.main.async {
                    self.weatherForecast = forecast
                }
            } catch {
                print("Error fetching weather data: \(error)")
            }
        }
    }
    
    func getSunEvents(location: Location) {
        Task {
            let weatherService = WeatherService()
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            do {
                let weather = try await weatherService.weather(for: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
                let dailyForecast = weather.dailyForecast
                if dailyForecast.indices.contains(1) {
                    let tomorrowForecast = dailyForecast[1]
                    self.sunriseTime = tomorrowForecast.sun.sunrise
                    self.sunsetTime = tomorrowForecast.sun.sunset
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
