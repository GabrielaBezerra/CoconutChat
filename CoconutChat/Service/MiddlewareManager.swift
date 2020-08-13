//
//  MiddlewareManager.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 12/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import RMQClient

class MiddlewareManager {
    
    private init() {}
    
    static let singleton: MiddlewareManager = MiddlewareManager()
    
    private let delegate = RMQConnectionDelegateLogger() // implement RMQConnectionDelegate yourself to react to errors
    private var connection: RMQConnection?
    
    private var channel: RMQChannel?
    private var queues: [RMQQueue] = []
    
    func connect() {
        
        guard let myUsername = UserRepository.singleton.connectedUser?.username, myUsername.replacingOccurrences(of: " ", with: "") != "" else {
            print("You didn't connect yet")
            return
        }

        print("Opening connection...")
        let conn = RMQConnection(uri: "amqp://guest:guest@localhost:5672", delegate: self.delegate)
        conn.start()
        self.connection = conn
        
        print("Creating channel...")
        let ch = conn.createChannel()
        self.channel = ch
        
        self.addQueue(named: myUsername, subscribe: true, onSubscribe: { msg, rmqMsg in
            
            // If message is an Invite
            let pieces = msg.split(separator: ":")
            if pieces.first == "subscribe-me", let usernameToConnect = pieces.last {
                
                guard let myUsername = UserRepository.singleton.connectedUser?.username, myUsername.replacingOccurrences(of: " ", with: "") != "" else {
                    print("#Error you didn't connect yet")
                    return
                }
                
                //Cria fila de mensagens
                self.addQueue(named: "\(myUsername):\(usernameToConnect)")
                
                //Cria fila de mensagens e assina
                self.addQueue(named: "\(usernameToConnect):\(myUsername)", subscribe: true, onSubscribe: { msg, timestamp in
                    print(usernameToConnect, msg)
                    
                    ChatRepository.singleton.receiveMessage(
                        Message(
                            content: msg,
                            user: User(username: "\(usernameToConnect)", origin: .contact),
                            timestamp: timestamp
                        )
                    )
                })
                
                self.push(message: "Hi! I subscribed to you too!", to: "\(myUsername):\(usernameToConnect)")
                
                DispatchQueue.main.async {
                    ContactRepository.singleton.contacts.append(User(username: "\(usernameToConnect)", origin: .contact))
                }
            }
        })
    }
    
    @discardableResult
    func addQueue(named queueName: String, subscribe: Bool = false, onSubscribe completion: @escaping (String, Double) -> Void = { _,_ in }) -> RMQQueue? {
        
        guard let channel = channel else {
            print("#Error no channel found.")
            return nil
        }
        
        //print("Add queue \(queueName)")
        let q = channel.queue(queueName)
        self.queues.append(q)
        
        if subscribe {
            self.subscribe(to: q, completion: completion)
        }
        
        return q
    }
    
    func subscribe(to queue: RMQQueue, completion: @escaping (String, Double) -> Void = { _,_  in }) {
        
        queue.subscribe { m in
            guard let msg = String(data: m.body, encoding: String.Encoding.utf8) else {
                print("#Error no readable msg received")
                return
            }
            
            guard let timestamp = Double("\(msg.split(separator: "⌚︎").last!)") else {
                print("No timestamp")
                return
            }
            
            guard let content = msg.split(separator: "⌚︎").first else {
                print("No content")
                return
            }
            
            completion("\(content)", timestamp)
        }
        
        print("Subscribed to \(queue.name)")
    }
    
    func push(message: String, to queueName: String) {
        
        guard let channel = channel else {
            print("#Error no channel found.")
            return
        }

        let queue = channel.queue(queueName)
        
        let timestamp = Date().timeIntervalSince1970
        
        if let data = "\(message)⌚︎\(timestamp)".data(using: String.Encoding.utf8) {
            queue.publish(data)
            print("Pushed msg to \(queueName)")
            
            if let contactUsername = queueName.split(separator: ":").last, message.split(separator: ":").first != "subscribe-me" {
                ChatRepository.singleton.sendMessage(
                    content: message,
                    to: User(username: "\(contactUsername)", origin: .contact),
                    timestamp: timestamp
                )
            }
        } else {
            print("#Error message could not be encoded to data and sent to queue \(queueName)")
        }
    }
    
    func connectTo(contact contactUsername: String, subscribeMe: Bool = false) {
        guard let myUsername = UserRepository.singleton.connectedUser?.username, myUsername.replacingOccurrences(of: " ", with: "") != "" else { return }
              
        print("connectTo contact \(contactUsername)")
        if subscribeMe {
            self.push(message: "subscribe-me:\(myUsername)", to: "\(contactUsername)")
            self.push(message: "Hello :) I just subscribed to you and sent a contact connection message.", to: "\(myUsername):\(contactUsername)")
        }
        
    }
    
    func closeConnection() {
        print("Closing connection...")
        self.connection?.close()
        self.connection = nil
    }
    
}
