//
//  RPParseHelper.m
//  Jogo das Palavras
//
//  Created by Ricardo Paiva on 11/08/16.
//
//

#import "RPParseHelper.h"
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>

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

+ (void)userIsLoggedInAndVerifiedWithCompletionBlock:(void (^)(BOOL emailVerified, NSError *error))completionBlock
{
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        [RPParseHelper userEmailIsVerified:currentUser completionBlock:^(BOOL emailVerified, NSError *error) {
            completionBlock(emailVerified, error);
        }];
    } else {
        completionBlock(NO, nil);
    }
}

+ (void)userEmailIsVerified:(PFUser *)user completionBlock:(void (^)(BOOL emailVerified, NSError *error))completionBlock
{
    BOOL linkedWithFacebook = [PFFacebookUtils isLinkedWithUser:user];
    if (linkedWithFacebook) {
        if ([FBSDKAccessToken currentAccessToken] != nil) {
            completionBlock(YES, nil);
        } else {
            completionBlock(NO, nil);
        }
    } else {
        if (![[user objectForKey:@"emailVerified"] boolValue]) {
            [user fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                if (error) {
                    completionBlock(NO, error);
                } else {
                    completionBlock([[user objectForKey:@"emailVerified"] boolValue], error);
                }
            }];
        } else {
            completionBlock([[user objectForKey:@"emailVerified"] boolValue], nil);
        }
    }
}

+ (void)logInParseUsingFBCurrentAccessTokenWithCompletionBlock:(void (^)(PFUser *user, NSError *error))completionBlock
{
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) {
        FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
        [PFFacebookUtils logInInBackgroundWithAccessToken:accessToken block:^(PFUser *user, NSError *error) {
            completionBlock(user, error);
        }];
    } else {
        completionBlock(currentUser, nil);
    }
}

@end
