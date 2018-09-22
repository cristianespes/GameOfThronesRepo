//
//  WikiViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 17/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    // MARK: - Views-Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Model
    var model : House!
    
    // MARK: - Initialization
    init(model: House) {
        // 1. - Asigno el modelo
        self.model = model
        // 2. - Llamo a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        // 3. -  Usar las properties de la superclase si es necesario
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() { // Cuando todos mis outlets han sido cargados, no son nil
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    // MARK: - Lyfe Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil) // Object es el que manda la notificacion
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja las notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        // Sacar la información y extraer la casa
        guard let info = notification.userInfo, let house = info[Constants.houseKey] as? House else { return }
        // Actualizar el modelo
        self.model = house
        // Sincronizar modelo - vista
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        let backItem = UIBarButtonItem()
        backItem.title = model.name
        navigationItem.backBarButtonItem = backItem
        
        //navigationController?.navigationBar.backItem?.title = model.name
        
        title = model.name
        let request: URLRequest = URLRequest(url: model.wikiUrl)
        loadingView.startAnimating()
        webView.load(request)
    }

}

extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let type = navigationAction.navigationType
        
        switch type {
        case .linkActivated, .formSubmitted, .formResubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}
