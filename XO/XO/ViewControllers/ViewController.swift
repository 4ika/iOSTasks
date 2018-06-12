//
//  ViewController.swift
//  XO
//
//  Created by I on 10.05.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import Cartography

class ViewController : UIViewController {

    let players = ["x":"o","o":"x"]
    var currentPlayer = "o"
    let messenger: Dictionary<String,String> = ["Your apponent waiting..." : "Your apponent thinking...","Your apponent thinking..." : "Your apponent waiting..."]
    
    
    var peerID:MCPeerID!
    var mcSession:MCSession!
    var mcAdvertiserAssistant:MCAdvertiserAssistant!
    
    lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init()
        return layout
    }()
    
    lazy var collectionView:UICollectionView = {
        let collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collection.layer.cornerRadius = 10
        collection.backgroundColor = UIColor.init(red: 51/255, green: 147/255, blue: 252/255, alpha: 1)
        collection.delegate = self
        collection.dataSource = self
        collection.allowsSelection = false
        return collection
    }()
    
    lazy var messengerLabel:UILabelPadding = {
        let label = UILabelPadding.init()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textColor = UIColor.init(red: 51/255, green: 147/255, blue: 252/255, alpha: 1)
        label.layer.borderWidth = 4
//        label.layer.borderColor = UIColor.init(red: 227/255, green: 229/255, blue: 232/255, alpha: 1).cgColor
        label.layer.borderColor = UIColor.init(red: 51/255, green: 147/255, blue: 252/255, alpha: 1).cgColor
        label.layer.cornerRadius = 6
        label.text = "If you want play game click to 2 players button..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.sizeToFit()
        return label
    }()
    
    lazy var connectButton:UIButton = {
        let button = UIButton.init()
        button.backgroundColor = UIColor.init(red: 51/255, green: 147/255, blue: 252/255, alpha: 1)
        button.setTitle("2 Players", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionsForConnectWithDevices), for: .allEvents)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupView()
        setupConstrains()
        setupNavigationBar()
        setupMPC()
    }
    
    func setupBackground() -> Void {
        self.view.backgroundColor = .white
    }
    
    func setupView() -> Void {
        self.view.addSubview(collectionView)
        self.view.addSubview(connectButton)
        self.view.addSubview(messengerLabel)
    }

    func setupNavigationBar() -> Void {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func setupConstrains() -> Void {
        constrain(collectionView,connectButton,messengerLabel){ collectionView,connectButton,messengerLabel in
            
            collectionView.height == 305
            collectionView.width == 305
            collectionView.center == (collectionView.superview?.center)!
            print(Int.init(CGFloat.init(320).truncatingRemainder(dividingBy: 6)))
            
            connectButton.width == collectionView.width * 0.9
            connectButton.height == self.view.frame.width/8.3
            connectButton.centerX == (connectButton.superview?.centerX)!
            connectButton.bottom == (connectButton.superview?.bottom)! - self.view.frame.width / 7.5
            
            
            messengerLabel.centerX == (collectionView.centerX)
            messengerLabel.top == (messengerLabel.superview?.top)!
            messengerLabel.width == collectionView.width * 0.95
    
        }
    }
    
    func setupMPC() -> Void {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
    }
    
   
    
    @objc func optionsForConnectWithDevices() -> Void {
        print(mcSession)
        let actionSheet = UIAlertController(title: "ToDo Exchange", message: "Do you want to Host or Join a session?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Host Session", style: .default, handler: { (action:UIAlertAction) in
            self.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "xo", discoveryInfo: nil, session: self.mcSession)
            self.mcAdvertiserAssistant.start()
            self.messengerLabel.text = "Your create host..."
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Join Session", style: .default, handler: { (action:UIAlertAction) in
            if self.mcSession.connectedPeers.count < 1 {
                let mcBrowser = MCBrowserViewController(serviceType: "xo", session: self.mcSession)
                mcBrowser.delegate = self
                mcBrowser.maximumNumberOfPeers = 2
                self.present(mcBrowser, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as? CollectionViewCell
        cell?.backgroundColor = .white
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentPlayer = players[currentPlayer]!
        messengerLabel.text = messenger[messengerLabel.text!]
        (collectionView.cellForItem(at: indexPath) as? CollectionViewCell)?.image.setPlayer(currentPlayer)
        let messageDict = ["cell":indexPath.row,"player":currentPlayer] as [String : Any]
        
        do{
            let messageData = try JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            try mcSession.send(messageData, toPeers: mcSession.connectedPeers, with: MCSessionSendDataMode.reliable)
            collectionView.allowsSelection = false
        }
        catch{}
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 300 / 6 , height: 300 / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension ViewController : MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        messengerLabel.text = "Your apponent thinking..."
        browserConnected()
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        if mcSession.connectedPeers.count == 1 {
            messengerLabel.text = "Your apponent thinking..."
            browserConnected()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func browserConnected() -> Void {
        let messageDict = ["state": "Your apponent waiting...","move":true] as [String : Any]
        
        do{
            let messageData = try JSONSerialization.data(withJSONObject: messageDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            try mcSession.send(messageData, toPeers: mcSession.connectedPeers, with: MCSessionSendDataMode.reliable)
        }
        catch{}
    }
}

extension ViewController : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do{
            let message = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
            if ((message.allKeys as? [String])?.contains("cell"))! {
                changeSituation(message: message)
            }
            else if ((message.allKeys as? [String])?.contains("state"))! {
                startGame(message: message)
            }
        }
        catch{
            print(error)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
    
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        if session.connectedPeers.count < 1 {
            
            DispatchQueue.main.async {
                self.messengerLabel.text = "Your apponent connecting..."
            }
            
            certificateHandler(true)
        }
        else {
            
            DispatchQueue.main.async {
                let alert = UIAlertController.init(title: "Attention...", message: "You cannot accepted this device because you have already your apponent...", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: { (_) in})
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
            certificateHandler(false)
        }
    }
    
    func changeSituation(message:NSDictionary) -> Void {
        let field:Int? = message.object(forKey: "cell") as? Int
        let player:String? = message.object(forKey: "player") as? String
        
        DispatchQueue.main.async {
            if field != nil  && player != nil {
                (self.collectionView.cellForItem(at: IndexPath.init(row: field!, section: 0)) as? CollectionViewCell)?.image.setPlayer(player!)
                self.currentPlayer = self.players[self.currentPlayer]!
                self.messengerLabel.text = self.messenger[self.messengerLabel.text!]
                self.collectionView.allowsSelection = true
            }
        }
    }
    
    func startGame(message:NSDictionary) -> Void {
        
        let move:Bool! = message.object(forKey: "move") as? Bool
        let state:String! = message.object(forKey: "state") as? String
        
        DispatchQueue.main.async {
            self.collectionView.allowsSelection = move
            self.messengerLabel.text = state
        }
    }
}

