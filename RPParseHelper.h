//
//  RPParseHelper.h
//  Jogo das Palavras
//
//  Created by Ricardo Paiva on 11/08/16.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface RPParseHelper : NSObject

/**
 *  Return the device id from the token registered in application
 *
 *  @param deviceToken -> deviceToken received in didRegisterForRemoteNotificationsWithDeviceToken, for example.
 *
 *  @return a string with the device id that can be used in push notications to identify this device.
 */
+ (NSString *)deviceIdFromToken:(NSData *)deviceToken;

/**
 *  Subscribes a specified channel
 *
 *  @param channel -> string with channel to subscribe.
 */
+ (void)subscribeToChannelInBackground:(NSString *)channel block:(PFBooleanResultBlock)block;

/**
 *  Unsubscribes a specified channel
 *
 *  @param channel -> string with channel to subscribe.
 */
+ (void)unsubscribeToChannelInBackground:(NSString *)channel block:(PFBooleanResultBlock)block;

@end
