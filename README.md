# Weather App

**Weather app** is an app that provide weather of your city or any city you want, you will find in this app everything you need to know about the weather.
This app use  [Dark Sky API](https://darksky.net/dev)
**Weather app** build with Swift. Feature this app same with apple weather like get current weather & details, get hourly forecast weather and get daily forecast. But we use limited free plan from [Dark Sky API](https://darksky.net/dev).
# **Screenshots :**
![SreenshotWeatherApp1](https://user-images.githubusercontent.com/62899755/78721080-c8056d00-791e-11ea-84fc-ba50b15cc2df.png)

# **Features :**

 1.  Powerfull Weather API.
 2. Display weather info : Currently Weather, hourly or weekly weather.
 3. Add many cities or your current location using GPS
 4. Time Format 12H or 24H
 5. Weather in celsius or fahrenheit.

# Keywords
- Swift 5
- Parsing JSON using Codable
- MVC
- Error Handling
- Core Data 

# Getting Started

## Requirement

-   A valid API key from [Dark Sky API](https://darksky.net/dev).
-   A Mac running macOS Catalina
-   Xcode 11.4

## Installation

1.  Clone or download the project to your local machine
2.  Open the project in Xcode
3.  Replace  `ApiKey`  with your valid Dark Sky API key in  `Global.swift`


```swift
struct Config{
	static let baseLink = "https://api.darksky.net/forecast/"
	static let ApiKey = "09e8e244326837f3038ae2e78dcb88f1"
}
```
4.  Run the app

## Author 
This app was made by me, Mohamed BENHASSI. If you want to contact me, please this in my web page [https://www.medbenhassi.com/](https://www.medbenhassi.com/).
Thank you.
