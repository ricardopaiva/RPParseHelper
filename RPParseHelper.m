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

+ (void)subscribeChannel:(NSString *)channel
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:channel forKey:@"channels"];
    [currentInstallation saveInBackground];
}

+ (void)unsubscribeChannel:(NSString *)channel
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation removeObject:channel forKey:@"channels"];
    [currentInstallation saveInBackground];
}

@end
