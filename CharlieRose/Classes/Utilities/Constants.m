//
//  Constants.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 02.12.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "Constants.h"


#define shouldUseRemoteServer false

#if shouldUseRemoteServer
NSString * const kAFContentBaseURL = @"http://107.21.216.249/ignant/ignant.php";
NSString * const kAdressForContentServer = @"http://107.21.216.249/ignant/ignant.php";
NSString * const kAdressForImageServer = @"http://107.21.216.249/ignant/imgsrv.php";
NSString * const kAdressForVideoServer = @"http://107.21.216.249/ignant/videosrv.php";
#else
NSString * const kAFContentBaseURL = @"http://192.168.2.107:9999/ign/ignant.php";
NSString * const kAdressForContentServer = @"http://192.168.2.107:9999/ign/ignant.php";
NSString * const kAdressForImageServer = @"http://www.ignant.de/app/imgsrv.php";
NSString * const kAdressForVideoServer = @"http://www.ignant.de/app/videosrv.php";
#endif