//
//  MoviesListViewController.swift
//  mobile development labs
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

	@IBOutlet weak var moviesView: MovieListView!
	@IBOutlet weak var movieSearchBar: UISearchBar!

	@IBOutlet weak var movieViewIsEmptyNotification: UILabel!

	var movieDetailsView: MovieDetailsView!
	var movieAddView: MovieAddView!

	var moviesViewDataSource: MovieList?

	func loadMovies() {
		if let moviesPath = Bundle.main.path(forResource: "Movies/MoviesList", ofType: "txt") {
			let moviesData = FileManager.default.contents(atPath: moviesPath)

			moviesViewDataSource = try! JSONDecoder().decode(MovieList.self, from: moviesData!)

			moviesViewDataSource!.Details = [:]

			moviesViewDataSource?.Search.forEach({
				if let movieDetailsPath = Bundle.main.path(forResource: "Movies/Details/\($0.imdbID)", ofType: "txt") {
					let movieDetailsData = FileManager.default.contents(atPath: movieDetailsPath)

					moviesViewDataSource!.Details?[$0.imdbID] = try! JSONDecoder().decode(MovieDetails.self, from: movieDetailsData!)
				}
			})

			movieViewIsEmptyNotification!.isHidden = moviesViewDataSource!.Search.count != 0
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		movieSearchBar.delegate = self

		loadMovies()

		moviesView.dataSource = moviesViewDataSource

		moviesView.delegate = self
		moviesView.dataSource = moviesViewDataSource
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let addMovieView = segue.destination.view as? MovieAddView {
			addMovieView.moviesViewController = self
		} else {
			movieDetailsView = segue.destination.view as? MovieDetailsView
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let movie = moviesViewDataSource?.Search[indexPath.row]
		let movieDetails = moviesViewDataSource!.Details![movie!.imdbID]
		movieDetailsView.detailsText.text =
		"""
		Title: \(movieDetails?.Title ?? movie?.Title ?? "-")

		Plot: \(movieDetails?.Plot ?? "-")

		Actors: \(movieDetails?.Actors ?? "-")

		Awards: \(movieDetails?.Awards ?? "-")

		Country: \(movieDetails?.Country ?? "-")

		Director: \(movieDetails?.Director ?? "-")

		Genre: \(movieDetails?.Genre ?? "-")

		Language: \(movieDetails?.Language ?? "-")

		Production: \(movieDetails?.Production ?? "-")

		Rated: \(movieDetails?.Rated ?? "-")

		Released: \(movieDetails?.Released ?? "-")

		Runtime: \(movieDetails?.Runtime ?? "-")

		Writer: \(movieDetails?.Writer ?? "-")

		Year: \(movieDetails?.Year ?? movie?.Year ?? "-")

		imdb ID: \(movieDetails?.imdbID ?? movie?.imdbID ?? "-")

		imdb Rating: \(movieDetails?.imdbRating ?? "-")

		imdb Votes: \(movieDetails?.imdbVotes ?? "-")
		"""

		if let posterPath = Bundle.main.path(forResource: "Movies/Posters/\(movieDetails?.Poster ?? "Poster_10.jpg")", ofType: "") {
			let imageData = FileManager.default.contents(atPath: posterPath)
			movieDetailsView?.poster.image = UIImage(data: imageData!)
		}
	}

	func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
		movieViewIsEmptyNotification.isHidden = moviesViewDataSource!.Filtered == nil ? moviesViewDataSource!.Search.count != 0 : moviesViewDataSource!.Filtered!.count != 0
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		moviesViewDataSource!.Filtered = moviesViewDataSource!.Search.filter {
			return $0.Title.starts(with: searchText)
		}
		movieViewIsEmptyNotification!.isHidden = moviesViewDataSource!.Filtered!.count != 0
		moviesView.reloadData()
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		moviesViewDataSource!.Filtered = nil
		movieViewIsEmptyNotification!.isHidden = moviesViewDataSource!.Search.count != 0
		moviesView.reloadData()
	}


}

