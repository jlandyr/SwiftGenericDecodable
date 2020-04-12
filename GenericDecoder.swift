static func decodingTask<T: Decodable>(data: Data, dateFormat : DateFormatter?, decodingType: T.Type, completion:@escaping ((_ decodable: T?, _ error: Error?) -> Void)){
        DispatchQueue.global().async {
            do {
                let decoder = JSONDecoder()
                if let format  = dateFormat{
                    decoder.dateDecodingStrategy = .formatted(format)
                }
                let decodable = try decoder.decode(decodingType, from: data)
                DispatchQueue.main.async {
                    completion(decodable,nil)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        }
    }