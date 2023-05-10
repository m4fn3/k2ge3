#include <dlfcn.h>
#import <substrate.h>
#import <Foundation/Foundation.h>

inline bool getPrefBool(NSString *key){
    return [[[[NSUserDefaults alloc] initWithSuiteName:@"com.m4fn3.k2ge3.preferences.plist"] objectForKey:key] boolValue];
}

int sendChatChecked(void* this_) {
    return 0;
}
int destroyMessage(void* this_){
    return 0;
}

%ctor {
    NSString *appPath = [NSString stringWithFormat: @"%@%@", [[NSBundle mainBundle] bundlePath], @"/LINE"];
    void* exec = dlopen([appPath UTF8String], RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
    if (getPrefBool(@"read")){
        void* sym_sendChatChecked = dlsym(exec, "LineTalkService_sendChatChecked");
        MSHookFunction((void *)sym_sendChatChecked ,(void*)sendChatChecked, NULL);
    }
    if (getPrefBool(@"unsend")){
        void* sym_destroyMessage = dlsym(exec, "$s13LineMessaging7ChatDAOC14destroyMessage4with2inySo0A9OperationC_So22NSManagedObjectContextCtFZ");
        MSHookFunction((void *)sym_destroyMessage ,(void*)destroyMessage, NULL);
    }
}
