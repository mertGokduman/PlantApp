//
//  WebViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 2.04.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let btnClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"),
                             for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    var urlString: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        setupUI()
    }

    private func setupUI() {

        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        btnClose.addTarget(self,
                           action: #selector(dismissVC),
                           for: .touchUpInside)
        view.addSubview(btnClose)
        NSLayoutConstraint.activate([
            btnClose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            btnClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnClose.heightAnchor.constraint(equalToConstant: 48),
            btnClose.widthAnchor.constraint(equalToConstant: 48)
        ])

        self.openWebUrl()
    }

    func openWebUrl() {
        if let url = URL(string: self.urlString~) {
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url))
                self.webView.allowsBackForwardNavigationGestures = true
            }
        }
    }

    func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }


    func webView(_ webView: WKWebView,
                 didCommit navigation: WKNavigation!) {
        self.startLoading()
    }

    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        self.stopLoading()
    }

    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
}
