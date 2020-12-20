//
//  MovieAddView.swift
//  mobile development labs
//

import UIKit


class MovieAddView: UIView {

	var moviesViewController: MoviesViewController?

	@IBOutlet weak var TitleForm: UITextField!
	@IBOutlet weak var YearForm: UITextField!

	@IBAction func clickAddMovie(_ sender: Any) {
		if TitleForm.hasText && YearForm.hasText {
			let userMovie = Movie(Title: TitleForm.text!, Year: YearForm.text!, Poster: "Poster_10.jpg", imdbID: "user_imdbID")
			if moviesViewController!.moviesViewDataSource!.Filtered != nil && userMovie.Title.starts(with: moviesViewController!.movieSearchBar.text!) {
				moviesViewController!.moviesViewDataSource!.Filtered!.append(userMovie)
			}
			moviesViewController!.moviesViewDataSource!.Search.append(userMovie)
			moviesViewController!.movieViewIsEmptyNotification.isHidden = moviesViewController!.moviesViewDataSource!.Filtered == nil ? moviesViewController!.moviesViewDataSource!.Search.count != 0 : moviesViewController!.moviesViewDataSource!.Filtered!.count != 0
			moviesViewController!.moviesView.reloadData()
		}
	}

}
