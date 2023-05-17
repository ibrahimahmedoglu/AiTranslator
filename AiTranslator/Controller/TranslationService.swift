import Foundation

class TranslationService {
    func translateText(apiKey: String, text: String, targetLanguage: String, sourceLanguage: String, completion: @escaping (Result<TranslationResponse, Error>) -> Void) {
        let urlString = "https://api-free.deepl.com/v2/translate"
        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let apiKeyItem = URLQueryItem(name: "auth_key", value: apiKey)
        let textItem = URLQueryItem(name: "text", value: text)
        let targetLanguageItem = URLQueryItem(name: "target_lang", value: targetLanguage)
        let sourceLanguageItem = URLQueryItem(name: "source_lang", value: sourceLanguage)
        
        urlComponents.queryItems = [apiKeyItem, textItem, targetLanguageItem, sourceLanguageItem]
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let translationResponse = try decoder.decode(TranslationResponse.self, from: data)
                    completion(.success(translationResponse))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            }
        }
        
        task.resume()
    }
}
