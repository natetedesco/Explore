//
//  Conditions.swift
//  Explore
//
//  Created by Developer on 5/21/24.
//

import SwiftUI

struct Conditions: View {
    @State var weather = Weather()
    @Binding var location: Location
    @State var text: String = ""
    
    var body: some View {
        
        VStack(spacing: 8) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("10 DAY FORECAST")
                    Image(systemName: "sun.max.fill")
                }
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
                .padding(.bottom, 8)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 28) {
                        if let forecast = weather.weatherForecast {
                            ForEach(forecast, id: \.date) { dailyWeather in
                                VStack(spacing: 12) {
                                    Text(dayOfWeek(from: dailyWeather.date))
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Image(systemName: dailyWeather.symbolName.appending(".fill"))
                                        .font(.title3)
                                        .symbolRenderingMode(.multicolor)
                                        .fontWeight(.bold)
                                        .frame(height: 32)
                                    
                                    Text(temperatureString(dailyWeather.highTemperature))
                                        .font(.title3)
                                        .fontWeight(.medium)
                                }
                            }
                        } else {
                            Text("Loading weather forecast...")
                        }
                    }
                    .padding(.leading, 20)
                }
                .padding(.horizontal, -20)
                .scrollIndicators(.hidden)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .background(.bar)
            .cornerRadius(16)
            
            HStack(spacing: 8) {
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("SUNRISE")
                        Image(systemName: "sunset.fill")
                    }
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    
                    HStack(alignment: .bottom) {
                        Text(formatTime(weather.sunriseTime))
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .padding(.bottom, -6)
                        Text("AM")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                    .padding(.top, 8)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.bar)
                .cornerRadius(16)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("SUNSET")
                        Image(systemName: "sunrise.fill")
                    }
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    
                    HStack(alignment: .bottom) {
                        Text(formatTime(weather.sunsetTime))
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .padding(.bottom, -6)
                        Text("PM")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                    .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.bar)
                .cornerRadius(16)
            }
        }
        .onAppear {
            weather.fetchWeatherData(for: location)
            weather.getSunEvents(location: location)
        }
    }
    
    private func temperatureString(_ temperature: Measurement<UnitTemperature>) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.string(from: temperature).trimmingCharacters(in: .letters.union(.whitespaces))
    }
    
    private func dayOfWeek(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
    
    func formatTime(_ time: Date?) -> String{
        guard let time = time else { return "0:00" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        return dateFormatter.string(from: time)
    }
}

#Preview {
    Conditions(location: .constant(locations[0]))
        .padding(.horizontal, 20)
}


