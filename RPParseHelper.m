//
//  RPParseHelper.m
//  Jogo das Palavras
//
//  Created by Ricardo Paiva on 11/08/16.
//
//

#import "RPParseHelper.h"

@implementation RPParseHelper

+ (NSString *)deviceIdFromToken:(NSData *)deviceToken
{
    NSString *device = [deviceToken description];
    device = [device stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    device = [device stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return device;
}

+ (void)subscribeToChannelInBackground:(NSString *)channel block:(PFBooleanResultBlock)block
{
    [PFPush subscribeToChannelInBackground:channel block:block];
    
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    [currentInstallation addUniqueObject:channel forKey:@"channels"];
//    [currentInstallation saveInBackground];
}

+ (void)unsubscribeToChannelInBackground:(NSString *)channel block:(PFBooleanResultBlock)block
{
    [PFPush unsubscribeFromChannelInBackground:channel block:block];
    
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    [currentInstallation removeObject:channel forKey:@"channels"];
//    [currentInstallation saveInBackground];
}

+ (BOOL)verifiedUserIsLoggedIn
{
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        if (![[currentUser objectForKey:@"emailVerified"] boolValue]) {
            [currentUser fetch];
        }
    }
    
    BOOL emailIsVerified = [[currentUser objectForKey:@"emailVerified"] boolValue];
    
    return (currentUser && emailIsVerified);
}

@end
