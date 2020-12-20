//
//  ImagesViewController.swift
//  mobile development labs
//

import UIKit


class ImagesViewController: UIViewController, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var PicturesCollectionView: UICollectionView!

	var ImagesDataSource = ImagesViewDataSource()
	var ImagePicker: UIImagePickerController?

	override func viewDidLoad() {
		super.viewDidLoad()

		PicturesCollectionView.delegate = self
		PicturesCollectionView.dataSource = ImagesDataSource

		ImagePicker = UIImagePickerController()
		ImagePicker!.delegate = self
		ImagePicker!.allowsEditing = true
		ImagePicker!.mediaTypes = ["public.image"]
		ImagePicker!.sourceType = .photoLibrary
		ImagePicker!.modalPresentationStyle = UIModalPresentationStyle.currentContext
	}

	@IBAction func AddPicture(_ sender: Any) {
		self.present(ImagePicker!, animated: true)
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		self.dismiss(animated: true, completion: nil)
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		guard let image = info[.editedImage] as? UIImage else {
			return
		}
		ImagesDataSource.Images.append(image)
		PicturesCollectionView.reloadData()
		self.dismiss(animated: true, completion: nil)
	}


}

