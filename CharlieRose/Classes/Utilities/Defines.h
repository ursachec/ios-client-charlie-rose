//
//  Defines.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 16.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#ifndef CharlieRose_Defines_h
#define CharlieRose_Defines_h

NS_INLINE void MVComputeTimeWithNameAndBlock(const char *caller, void (^block)()) {
    CFTimeInterval startTimeInterval = CACurrentMediaTime();
    block();
    CFTimeInterval nowTimeInterval = CACurrentMediaTime();
    NSLog(@"%s - Time Running is: %f", caller, nowTimeInterval - startTimeInterval);
}

#define MVComputeTime(...) MVComputeTimeWithNameAndBlock(__PRETTY_FUNCTION__, (__VA_ARGS__))


#endif
