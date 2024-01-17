//
//  NotificationService.swift
//  NotificationExtension
//
//  Created by Hunyady, Mihaly on 16/01/2024.
//

import UserNotifications
import EmarsysNotificationService

class NotificationService: EMSNotificationService {

    open override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
          if request.content.userInfo.contains(where: {$0.key as! String == "customLogicKey"}) {
              // do smth wih your other notificationservice logic
          } else {
              super.didReceive(request, withContentHandler: contentHandler)
          }
      }
}
