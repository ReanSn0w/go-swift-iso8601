    import XCTest
    import Foundation
    @testable import ISO8601
    
    class Test: Codable {
        let date: Date
    }

    final class ISO8601Tests: XCTestCase {
        func testJSONEncoder() {
            let test: [String] = [
                "{\"date\":\"2021-08-23T22:25:52.966680994Z\"}"
            ]
            
            for val in test {
                do {
                    let date = try jsonDecoder.decode(Test.self, from: val.data(using: .utf8)!)
                    print(date.date)
                } catch {
                    XCTFail()
                }
            }
        }
        
        var jsonDecoder: JSONDecoder {
            let dec = JSONDecoder()
            dec.dateDecodingStrategy = .iso8601withFractionalSeconds
            return dec
        }
    }
