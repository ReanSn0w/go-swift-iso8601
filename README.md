# ISO8601

Пакет для распакевки дат из json по стандарту iso8601

`
var jsonDecoder: JSONDecoder {
    let dec = JSONDecoder()
    dec.dateDecodingStrategy = .iso8601withFractionalSeconds
    return dec
}
`
