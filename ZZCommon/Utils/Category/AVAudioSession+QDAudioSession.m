//
//  AVAudioSession+QDAudioSession.m

//  Created by mac on 2022/8/29.
//

#import "AVAudioSession+QDAudioSession.h"

@implementation AVAudioSession (QDAudioSession)

- (BOOL)setActive:(BOOL)active withOptions:(AVAudioSessionSetActiveOptions)options error:(NSError *__autoreleasing  _Nullable * _Nullable)outError {
    return active;
}

@end
