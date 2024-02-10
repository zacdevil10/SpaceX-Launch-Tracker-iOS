//
//  NewsScreen.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 10/02/2024.
//

import SwiftUI
import SafariServices

struct NewsScreen: View {
    
    @StateObject private var viewModel: ArticlesViewModel = ArticlesViewModel()
    
    @State private var isPresentingWebView = false
    @State private var url: String = ""
    
    var body: some View {
        Screen(result: viewModel.articles) { data in
            List {
                ForEach(data) { article in
                    Article(
                        title: article.title,
                        url: article.url,
                        image: article.image,
                        site: article.site,
                        published: article.published
                    )
                    .onAppear() {
                        Task {
                            await viewModel.fetchNextArticles(id: article.id)
                        }
                    }
                    .onTapGesture {
                        url = article.url
                        isPresentingWebView = true
                    }
                }
                
                if case .success = viewModel.articles {
                    pagingIndicator
                        .listRowSeparator(.hidden)
                }
            }
            .fullScreenCover(isPresented: $isPresentingWebView) { [url] in
                NavigationStack {
                    if let url = URL(string: url) {
                        SafariView(url: url)
                    } else {
                        Text("")
                            .task {
                                isPresentingWebView = false
                            }
                    }
                }
            }
        }
    }
    
    var pagingIndicator: some View {
        HStack(alignment: .center) {
            switch viewModel.articlesLoadState {
            case .success:
                EmptyView()
            case .pending:
                Spacer()
                ProgressView()
                Spacer()
            case .error(_):
                Text("Error")
            }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}

#Preview {
    NewsScreen()
}
