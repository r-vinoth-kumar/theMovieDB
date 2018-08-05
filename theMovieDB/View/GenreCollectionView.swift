//
//  GenreCollectionView.swift
//  theMovieDB
//
//  Created by Vinoth Kumar Ramalingam on 05/08/18.
//  Copyright © 2018 Vinoth Kumar Ramalingam. All rights reserved.
//

import UIKit

class GenreCollectionView: UICollectionView {
    var genreList : [Genre]? {
        didSet {
            DispatchQueue.main.async {
                self.delegate = self
                self.dataSource = self
                self.reloadData()
            }
        }
    }
}

extension GenreCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCell
        cell.genre.clipsToBounds = true
        cell.genre.text = genreList?[indexPath.row].name ?? ""
        return cell
    }
}

extension GenreCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
