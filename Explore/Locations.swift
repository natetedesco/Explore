//
//  Locations.swift
//  Explore
//  Created by Developer on 6/25/24.
//

import Foundation
import MapKit

var locations: [Location] = [
    
    // Bay Area Testing
    Location(name: "Black Sands Beach", location: "California", tags: ["Beach"], priority: 5, latitude: 37.8243366, longitude: -122.5084973),
    Location(name: "Devil's Slide Coast", location: "Pacifica, California", priority: 6, latitude: 37.580858, longitude: -122.517364),
    Location(name: "Indian Rock", location: "Berkely, California", tags: ["Scenic"], priority: 6, latitude: 37.8919993609925, longitude: -122.27374595546446),
    Location(name: "Ocean Beach", location: "San Francisco", tags: ["Beach"], priority: 7, latitude: 37.7565493, longitude: -122.5089131),
    Location(name: "Baker Beach", location: "San Francisco", tags: ["Beach"], priority: 7, latitude: 37.7934398, longitude: -122.4837399),
    Location(name: "China Beach", location: "San Francisco", tags: ["Beach"], priority: 6, latitude: 37.7879627, longitude: -122.4911857),
    Location(name: "Angel Island", location: "San Francisco", tags: ["Scenic, Hiking, Forest"], priority: 5, latitude: 37.8644, longitude: -122.4297),
    Location(name: "Golden Gate Park", location: "San Francisco", tags: ["Scenic, Hiking, Forest, Lake, Waterfall"], priority: 5, latitude: 37.7685521, longitude: -122.4816155),
    Location(name: "Thornton State Beach", location: "San Mateo County", tags: ["Beach, Scenic, Hiking, Forest"], priority: 4, latitude: 37.6920453, longitude: -122.498142),
    Location(name: "Point San Pedro", location: "Pacifica", tags: ["Beach, Scenic, Hiking"], priority: 4, latitude: 37.5937, longitude: -122.5184),
    Location(name: "Dunes Beach", location: "Half Moon Bay", tags: ["Beach, Scenic, Hiking"], priority: 4, latitude: 37.48448, longitude: -122.45357),
    
    // Priority 1
    Location(name: "Big Sur",location: "California",tags: ["Top", "Scenic", "Coastal", "Beach", "Forest"],priority: 1,latitude: 36.2702,longitude: -121.8074,isExample: true),
    Location(name: "Yosemite", location: "National Park", tags: ["Top", "Scenic", "Mountain", "Forest"], priority: 1, latitude: 37.8651, longitude: -119.5383),
    Location(name: "Redwood Forest", location: "National Park", tags: ["Top", "Scenic", "Forest"], priority: 1, latitude: 41.2132, longitude: -124.0046),
    Location(name: "Catalina Island", location: "Channel Islands", tags: ["Top", "Scenic", "Island"], priority: 1, latitude: 33.3879, longitude: -118.4168),
    Location(name: "Joshua Tree", location: "National Park", tags: ["Top", "Scenic", "Desert"], priority: 1, latitude: 33.8734, longitude: -115.9010),
    Location(name: "Lake Tahoe", location: "California", tags: ["Top", "Scenic", "Lake"], priority: 1, latitude: 39.0968, longitude: -120.0324),
    Location(name: "Sequoia", location: "National Park", tags: ["Top", "Scenic", "Forest"], priority: 1, latitude: 36.4864, longitude: -118.5657),
    Location(name: "Death Valley", location: "National Park", tags: ["Top", "Scenic", "Desert"], priority: 1, latitude: 36.5323, longitude: -116.9325),
    Location(name: "Lassen Volcanic National Park", location: "National Park", tags: ["Scenic", "Park"], priority: 1, latitude: 40.4977, longitude: -121.4207),
    
    // Priority 2
    Location(name: "Point Reyes National Seashore", location: "Marin County", tags: ["Scenic", "Coastal", "Wildlife"], priority: 2, latitude: 38.0670, longitude: -122.9407),
    Location(name: "Mount Shasta", location: "Siskiyou County", tags: ["Scenic", "Mountain", "Volcano"], priority: 2, latitude: 41.4092, longitude: -122.1944),
    Location(name: "Mono Lake", location: "Mono County", tags: ["Scenic", "Lake", "Unique"], priority: 2, latitude: 38.0071, longitude: -119.0133),
    Location(name: "Mendocino Headlands State Park", location: "Mendocino", tags: ["Scenic", "Coastal", "Park"], priority: 2, latitude: 39.3050, longitude: -123.8005),
    Location(name: "Kings Canyon National Park", location: "California", tags: ["Scenic", "Mountain", "Forest"], priority: 2, latitude: 36.8879, longitude: -118.5551),
    Location(name: "Pfeiffer Beach", location: "Big Sur", tags: ["Scenic", "Beach"], priority: 3, latitude: 36.2384, longitude: -121.8150),
    Location(name: "Anza-Borrego Desert State Park", location: "San Diego County", tags: ["Scenic", "Desert", "Park"], priority: 2, latitude: 33.2550, longitude: -116.4018),
    Location(name: "Channel Islands National Park", location: "California", tags: ["Scenic", "Island", "Wildlife"], priority: 2, latitude: 34.0069, longitude: -119.7785),
    Location(name: "Alabama Hills", location: "Lone Pine", tags: ["Scenic", "Desert", "Mountain"], priority: 2, latitude: 36.6091, longitude: -118.1309),
    Location(name: "Point Lobos State Natural Reserve", location: "Carmel-by-the-Sea", tags: ["Scenic", "Coastal", "Wildlife"], priority: 2, latitude: 36.5135, longitude: -121.9422),
    Location(name: "Mount Whitney", location: "California", tags: ["Scenic", "Mountain", "Peak"], priority: 2, latitude: 36.5786, longitude: -118.2923),
    Location(name: "Salton Sea", location: "Imperial County", tags: ["Scenic", "Lake", "Desert"], priority: 2, latitude: 33.2593, longitude: -115.9230),
    Location(name: "Limekiln State Park", location: "Big Sur", tags: ["Scenic", "Forest", "Coastal"], priority: 2, latitude: 36.0106, longitude: -121.5180),
    Location(name: "Muir Woods National Monument", location: "San Francisco", priority: 3, latitude: 37.8915054, longitude: -122.5708057),
    Location(name: "Laguna Beach", location: "California", priority: 2, latitude: 33.545406, longitude: -117.781562),
    Location(name: "Trona Pinnacles", location: "San Bernadino, CA", priority: 2, latitude: 35.6177567, longitude: -117.36811),
    Location(name: "Guadalupe-Nipomo Dunes", location: "Santa Barbara County, CA", priority: 2, latitude: 34.967, longitude: -120.65),
    Location(name: "Eureka Dunes", location: "Death Valley, CA", priority: 2, latitude: 36.4212824, longitude: -117.0703125),
    Location(name: "Newport Back Bay", location: "Newport Beach", priority: 3, latitude: 33.615189, longitude: -117.89222),
    Location(name: "Burney Falls", location: "California", priority: 2, latitude: 41.01832, longitude: -121.647379),
]
