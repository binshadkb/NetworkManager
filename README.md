# NetworkManager

`NetworkManager` is a Swift package that provides an easy-to-use API client and URL builder for making network requests in your iOS applications. It simplifies the process of constructing URLs, sending HTTP requests, and handling responses. The package supports both regular and multipart requests and provides robust error handling and JSON decoding.

## Features

- **API Client**: Handles sending HTTP requests and parsing JSON responses.
- **URL Builder**: Constructs `URLRequest` with query parameters, headers, and body data.
- **Multipart Support**: Creates multipart/form-data requests for file uploads.
- **Error Handling**: Handles different HTTP status codes and provides custom error handling.
- **Async/Await Support**: Leverages Swift's async/await for asynchronous network calls.
  
## Installation

You can add `NetworkManager` to your project using Swift Package Manager.

### Using Xcode

1. Open your Xcode project.
2. Navigate to `File` > `Swift Packages` > `Add Package Dependency`.
3. Enter the following URL to add the package:
   
https://github.com/binshadkb/NetworkManager.git


4. Choose the version or branch you want to use.

## Usage

### 1. **ApiClient**

`ApiClient` is used to send HTTP requests and handle responses.

```swift
import NetworkManager

let apiClient = ApiClient()

// For GET request returning a decoded object
do {
 let response = try await apiClient.excecute(dataType: MyResponseModel.self, urlRequest: urlRequest)
 print("Response: \(response)")
} catch {
 print("Error: \(error.localizedDescription)")
}

// For GET request returning raw string
do {
 let response = try await apiClient.excecute(urlRequest: urlRequest)
 print("Response: \(response ?? "No data")")
} catch {
 print("Error: \(error.localizedDescription)")
}
```
### 2. **URLBuilder**
URLBuilder is used to construct URLRequest or simple URLs with query parameters.

```swift
import NetworkManager

let builder = URLBuilder()

// Build a URLRequest for a GET request
let urlRequest = builder.buildURL(
    baseURL: "https://api.example.com",
    path: "/path/to/resource",
    queryItems: [URLQueryItem(name: "id", value: "123")],
    httpMethod: "GET",
    headers: ["Authorization": "Bearer token"],
    bodyParams: nil
)

// Build a simple URL with query parameters
if let url = builder.buildURL(
    baseURL: "https://api.example.com",
    path: "/path/to/resource",
    queryItems: [URLQueryItem(name: "id", value: "123")]
) {
    print("URL: \(url)")
}

// Build a multipart/form-data request for file uploads
let multiPartRequest = builder.buildMultiPartURL(
    baseURL: "https://api.example.com",
    path: "/upload",
    queryItems: nil,
    httpMethod: "POST",
    headers: ["Authorization": "Bearer token"],
    dataArray: [MultiPartModel(key: "file", type: .file, data: fileData)]
)
```

**Example: Sending a Request**
Here’s an example of how to use both ApiClient and URLBuilder to send a network request.

```swift
import NetworkManager

let builder = URLBuilder()
let apiClient = ApiClient()

// Construct URLRequest
let urlRequest = builder.buildURL(
    baseURL: "https://api.example.com",
    path: "/path/to/resource",
    queryItems: [URLQueryItem(name: "id", value: "123")],
    httpMethod: "GET",
    headers: ["Authorization": "Bearer token"],
    bodyParams: nil
)!

// Execute the request
do {
    let response = try await apiClient.excecute(dataType: MyResponseModel.self, urlRequest: urlRequest)
    print("Response: \(response)")
} catch {
    print("Error: \(error.localizedDescription)")
}
```
**Classes**

ApiClient
ApiClient is responsible for performing HTTP requests. It handles both successful and failed requests, and it can return decoded objects or raw strings.

Methods:

excecute<T>(dataType: T.Type, urlRequest: URLRequest): Performs a network request and decodes the response into a specified Decodable type.
excecute(urlRequest: URLRequest): Performs a network request and returns the response as a string.
URLBuilder
URLBuilder provides methods for constructing URLRequest objects with various parameters.

Methods:

buildURL(baseURL: String, path: String, queryItems: [URLQueryItem]?, httpMethod: String, headers: [String: String], bodyParams: Any?): Builds a complete URLRequest with headers, body, and query parameters.
buildURL(baseURL: String, path: String, queryItems: [URLQueryItem]?): Builds a simple URL using base URL, path, and query items.
buildMultiPartURL(baseURL: String, path: String, queryItems: [URLQueryItem]?, httpMethod: String, headers: [String: String], dataArray: [MultiPartModel]): Builds a multipart/form-data request for file uploads.
Error Handling

The package uses the following error types:

ApiError: Custom error enum that handles errors like invalidResponse, unauthorized, parseError, and others.
License

This package is licensed under the MIT License. See the LICENSE file for more details.
