//
//  LoggerObjc.h
//  Dotzu
//
//  Created by Remi Robert on 18/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

@import Foundation;

#define NSLog(message, ...) [LoggerObjc verbose: [NSString stringWithFormat: message, ##__VA_ARGS__] file:[NSString stringWithUTF8String:__FILE__] function:[NSString stringWithUTF8String:__FUNCTION__] line:__LINE__]
#define LogVerbose(message, ...) [LoggerObjc verbose: [NSString stringWithFormat: message, ##__VA_ARGS__] file:[NSString stringWithUTF8String:__FILE__] function:[NSString stringWithUTF8String:__FUNCTION__] line:__LINE__]
#define LogWarning(message, ...) [LoggerObjc warning: [NSString stringWithFormat: message, ##__VA_ARGS__] file:[NSString stringWithUTF8String:__FILE__] function:[NSString stringWithUTF8String:__FUNCTION__] line:__LINE__]
#define LogInfo(message, ...) [LoggerObjc info: [NSString stringWithFormat: message, ##__VA_ARGS__] file:[NSString stringWithUTF8String:__FILE__] function:[NSString stringWithUTF8String:__FUNCTION__] line:__LINE__]
#define LogError(message, ...) [LoggerObjc error: [NSString stringWithFormat: message, ##__VA_ARGS__] file:[NSString stringWithUTF8String:__FILE__] function:[NSString stringWithUTF8String:__FUNCTION__] line:__LINE__]
