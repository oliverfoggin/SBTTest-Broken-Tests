import SwiftUI

struct VersionResponse: Decodable {
	let supportedVersions: [String]
}

class ContentViewModel: ObservableObject {
	let title: String
	@Published var version: String? = nil

	init(title: String) {
		self.title = title
	}

	func fetchVersions() {
		Task { [weak self] in
			do {
				let urlRequest = URLRequest(url: URL(string: "http://0.0.0.0:9292/versions")!)
				let (data, _) = try await URLSession.shared.data(for: urlRequest)
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let response = try decoder.decode(VersionResponse.self, from: data)

				DispatchQueue.main.async { [weak self] in
					self?.version = response.supportedVersions.first
				}
			} catch {
				print(error)
			}
		}
	}
}

struct ContentView: View {
	@ObservedObject var viewModel: ContentViewModel

	var body: some View {
		VStack {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundColor(.accentColor)
			Text(viewModel.title)

			if let version = viewModel.version {
				Text(version)
			}
		}
		.padding()
		.onAppear {
			viewModel.fetchVersions()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(viewModel: .init(title: "Test title."))
	}
}
