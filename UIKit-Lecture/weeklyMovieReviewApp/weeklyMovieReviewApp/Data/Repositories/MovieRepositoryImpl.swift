//
//  MovieRepositoryImpl.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//

import Foundation

class MovieRepositoryImpl: MovieRepository {
    
    // 실제 API 키로 교체
    private let apiKey = "5048a66de8e54cbaa5cf03d63808dcef"
    private let kmdbApiKey = "BQ9R200TZ3OF4239DX4E"
    
    // 포스터 정보가 없을 경우 할당할 placeholder URL
    private let dummyPosterURL = "https://dummyimage.com/600x900/cccccc/ffffff.jpg&text=No+Poster"
    
    func fetchPopularMovies(completion: @escaping ([Movie]) -> Void) {
        // 테스트용 실제 데이터가 있는 과거 날짜로 설정 (미래 날짜는 데이터 없음)
        let targetDate = "20250301"
        
        // KOBIS 일일 박스오피스 조회 API URL 구성
        let urlString = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(targetDate)"
        
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                print("데이터 에러: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            do {
                // KOBIS API 응답 JSON 파싱
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let boxOfficeResult = json["boxOfficeResult"] as? [String: Any],
                      let dailyBoxOfficeList = boxOfficeResult["dailyBoxOfficeList"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                // 영화 데이터를 매핑 (포스터는 빈 문자열로 초기화)
                var movies: [Movie] = dailyBoxOfficeList.compactMap { dict in
                    guard let movieCode = dict["movieCd"] as? String,
                          let movieName = dict["movieNm"] as? String else { return nil }
                    return Movie(id: movieCode, title: movieName, posterPath: "")
                }
                
                // 모든 영화에 대해 KMDB API로 포스터 URL 가져오기
                let group = DispatchGroup()
                for index in movies.indices {
                    group.enter()
                    // 영화 제목 URL 인코딩
                    guard let encodedTitle = movies[index].title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                        movies[index].posterPath = self.dummyPosterURL
                        group.leave()
                        continue
                    }
                    // KMDB API URL 구성 (HTTPS 사용)
                    let kmdbURLString = "https://api.kmdb.or.kr/v1/search/movie?serviceKey=\(self.kmdbApiKey)&movieNm=\(encodedTitle)"
                    
                    guard let kmdbURL = URL(string: kmdbURLString) else {
                        movies[index].posterPath = self.dummyPosterURL
                        group.leave()
                        continue
                    }
                    
                    URLSession.shared.dataTask(with: kmdbURL) { data, _, error in
                        defer { group.leave() }
                        if let error = error {
                            print("KMDB 포스터 데이터 에러: \(error.localizedDescription)")
                            movies[index].posterPath = self.dummyPosterURL
                            return
                        }
                        guard let data = data else {
                            movies[index].posterPath = self.dummyPosterURL
                            return
                        }
                        
                        do {
                            // KMDB API 응답 JSON 파싱 (실제 구조에 맞게 수정)
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let movieList = json["Data"] as? [[String: Any]],
                               let firstMovie = movieList.first,
                               let posterURL = firstMovie["posters"] as? String,
                               !posterURL.isEmpty {
                                movies[index].posterPath = posterURL
                            } else {
                                movies[index].posterPath = self.dummyPosterURL
                            }
                        } catch {
                            print("KMDB JSON 파싱 실패: \(error)")
                            movies[index].posterPath = self.dummyPosterURL
                        }
                    }.resume()
                }
                
                group.notify(queue: .main) {
                    completion(movies)
                }
                
            } catch {
                print("JSON 파싱 실패: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}
