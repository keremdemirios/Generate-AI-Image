//
//  ViewController.swift
//  AI Image
//
//  Created by Kerem Demir on 16.02.2024.
//

import UIKit

class ViewController: UIViewController {

    let imageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFill
       return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        Task {
            do {
                let image = try await APIService().fetchImageForPrompt("Üzüm toplayan seksi kadınlar")
                await MainActor.run {
                    imageView.image = image
                }
            } catch {
                print("Error !")
            }
            
        }
    }

    private func configureUI(){
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

