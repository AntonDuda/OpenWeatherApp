//
//  Alert.swift
//  OpenWeatherApp
//
//  Created by Anton on 06.02.2021.
//

class AlertMessage {
    
    var title = Constants.defaultAlertTitle.localized()
    var body = Constants.defaultAlertMessage.localized()
    
    private func parseApiError(data: Data?) -> AlertMessage {
            let decoder = JSONDecoder()
            if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
                return AlertMessage(title: Constants.errorAlertTitle.localized(), body: error.key?.localized() ?? error.message)
            }
            return AlertMessage(title: Constants.errorAlertTitle.localized(), body: Constants.genericErrorMessage)
        }
}
