//
//  MovieStruct.swift
//  mobile development labs
//

import UIKit


struct Movie: Decodable {
	var Title: String
	var Year: String
	var Poster: String

	var imdbID: String

	static func ==(lhs: Movie, rhs: Movie) -> Bool {
		lhs.Title == rhs.Title &&
		lhs.Year == rhs.Year &&
		lhs.imdbID == rhs.imdbID
	}
}

struct MovieDetails: Decodable {
	var imdbID: String?

	var Title: String?
	var Year: String?
	var Rated: String?
	var Released: String?
	var Runtime: String?
	var Genre: String?
	var Director: String?
	var Writer: String?
	var Actors: String?
	var Plot: String?
	var Language: String?
	var Country: String?
	var Awards: String?
	var Poster: String?
	var imdbRating: String?
	var imdbVotes: String?
	var Production: String?
}

class MovieList: NSObject, Decodable, UITableViewDataSource {

	var Search: [Movie]
	var Details: [String: MovieDetails]?

	var Filtered: [Movie]?

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Filtered == nil ? Search.count : Filtered!.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! MovieCell
		let posterPathString = "Movies/Posters/\(Filtered == nil ? Search[indexPath.row].Poster : Filtered![indexPath.row].Poster)"
		if let posterPath = Bundle.main.path(forResource: posterPathString, ofType: "") {
			let imageData = FileManager.default.contents(atPath: posterPath)
			cell.filmImage.image = UIImage(data: imageData!)
		} else if let posterPath = Bundle.main.path(forResource: "Movies/Posters/Poster_10", ofType: "jpg") {
			let imageData = FileManager.default.contents(atPath: posterPath)
			cell.filmImage.image = UIImage(data: imageData!)
		}
		cell.filmLabel.text = Filtered == nil ? Search[indexPath.row].Title : Filtered![indexPath.row].Title
		cell.year.text = Filtered == nil ? Search[indexPath.row].Year : Filtered![indexPath.row].Year
		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == UITableViewCell.EditingStyle.delete {
			if Filtered != nil {
				let index = Search.firstIndex(where: {
					movie in return movie == Filtered![indexPath.row]
				})
				Search.remove(at: index!)
				Details?.removeValue(forKey: Filtered![indexPath.row].imdbID)
				Filtered?.remove(at: indexPath.row)
			} else {
				Details?.removeValue(forKey: Search[indexPath.row].imdbID)
				Search.remove(at: indexPath.row)
			}
			tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
		}
	}
}
