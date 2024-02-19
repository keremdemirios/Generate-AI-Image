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
    
    let promptTextField: UITextField = {
        let promptTextField = UITextField()
        promptTextField.translatesAutoresizingMaskIntoConstraints = false
        promptTextField.leftViewMode = .always
        promptTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        promptTextField.autocapitalizationType = .none
        promptTextField.autocorrectionType = .no
        promptTextField.layer.cornerRadius = 10
        promptTextField.clipsToBounds = true
        promptTextField.layer.borderWidth = 1
        promptTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        promptTextField.backgroundColor = .systemGray5
        promptTextField.returnKeyType = .done
        promptTextField.placeholder = "Please Enter a Placeholder"
        return promptTextField
    }()
    
    lazy var submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.setTitle("Generate Image", for: .normal)
        submitButton.backgroundColor = .systemMint
        submitButton.layer.cornerRadius = 10
        return submitButton
    }()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    
    }

    private func configureUI(){
        
        view.addSubViews(imageView,promptTextField, submitButton, activityIndicator)
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            promptTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            promptTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            promptTextField.widthAnchor.constraint(equalToConstant: 300),
            promptTextField.heightAnchor.constraint(equalToConstant: 80),
            
            submitButton.topAnchor.constraint(equalTo: promptTextField.bottomAnchor, constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK : Functions
    private func fetchImageForPrompt(prompt: String) {
        activityIndicator.startAnimating()
        Task {
            do {
                let image = try await APIService().fetchImageForPrompt(prompt)
                await MainActor.run {
                    activityIndicator.stopAnimating()
                    imageView.image = image
                }
            } catch {
                activityIndicator.stopAnimating()
                print("Error !")
            }
            
        }
    }
    
    // MARK : Actions
    
    @objc func submitButtonTapped() {
        print("Submit Button Tapped.")
        
        promptTextField.resignFirstResponder()
        
        if let promptText = promptTextField.text, promptText.count > 3 {
            fetchImageForPrompt(prompt: promptText)
            print("Drawing.")
            print(promptText)
        } else {
            let alert = UIAlertController(title: "Invalid entry.", message: "Please describe the post you want to be drawn with at least 3 letters and 1 word.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in print("OK Tapped.")} ))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

