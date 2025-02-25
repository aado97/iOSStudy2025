//
//  NewsListView.swift
//  CombineSwiftUIEx
//
//  Created by 도민준 on 2/15/25.
//

import SwiftUI
import Combine

struct News: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}


class NewsService {
  func fetchNews() -> AnyPublisher<[News], Never> {
    let sampleNews = [
      News(title: "SwiftUI", description: "Learn SwiftUI with Combine"),
      News(title: "Combine", description: "Reactive Programming in Swift")
    ]
    return Just(sampleNews)
      .eraseToAnyPublisher()
  }
}

struct NewsListView: View {
  @State private var newsList: [News] = []
  private let newsService = NewsService()
  @State private var cancellable: AnyCancellable?
  
  var body: some View {
    List(newsList) { news in
      VStack(alignment: .leading) {
        Text(news.title)
          .font(.headline)
        Text(news.description)
          .font(.subheadline)
          .foregroundColor(.gray)
      }
    }
    .onAppear {
      cancellable = newsService.fetchNews()
        .sink { news in
          self.newsList = news
        }
    }
  }
}


#Preview {
  NewsListView()
}
