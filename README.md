# GoodWeather

![RocketSim_Recording_iPhone_12_2022-07-24_15 29 33](https://user-images.githubusercontent.com/47273077/180635333-12dd79e0-66ad-4513-9f5d-10971d23fbce.gif)

## ViewController
```swift
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityNameTextField.rx.value
            .subscribe(onNext: { city in

                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }

            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℉"
            self.humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            self.temperatureLabel.text = "🙈"
            self.humidityLabel.text = "⚉"
        }
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else {
            return
        }
        
        let resource = Resource<WeatherResult>(url: url)
        
        URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catchAndReturn(WeatherResult.empty)
            .subscribe(onNext: { result in
                let weather = result.main
                self.displayWeather(weather)
            }).disposed(by: disposeBag)
    }

}

```
