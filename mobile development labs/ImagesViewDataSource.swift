//
//  ImagesViewDataSource.swift
//  mobile development labs
//

import UIKit


class ImagesViewDataSource: NSObject, UICollectionViewDataSource {

	var Images: [UIImage] = []

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return Images.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! ImageCell
		cell.ImageView.image = Images[indexPath.row]
		return cell
	}

}
