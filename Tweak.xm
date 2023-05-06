#include <dlfcn.h>
#import <substrate.h>
#import <Foundation/Foundation.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.m4fn3.k2ge3-pref.plist"

inline bool getPrefBool(NSString *key){
    return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] objectForKey:key] boolValue];
}

int sendChatChecked(void* this_) {
    return 0;
}
int destroyMessage(void* this_){
    return 0;
}

// static NSString *accessGroupID() {
//     NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
//                            (__bridge NSString *)kSecClassGenericPassword, (__bridge NSString *)kSecClass,
//                            @"bundleSeedID", kSecAttrAccount,
//                            @"", kSecAttrService,
//                            (id)kCFBooleanTrue, kSecReturnAttributes,
//                            nil];
//     CFDictionaryRef result = nil;
//     OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
//     if (status == errSecItemNotFound){
//         status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
//         if (status != errSecSuccess){
//             return nil;
//         }
//     }
//     NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge NSString *)kSecAttrAccessGroup];
//     NSLog(@"k2ge3l | accessGroup : %@", accessGroup);
//     return accessGroup;
// }
//
//
// %hook FBSDKKeychainStore
// - (FBSDKKeychainStore *)initWithService:(NSString *)service accessGroup:(NSString *)accessGroup {
// 	accessGroupID();
//     return %orig(service, accessGroup);
// }
// %end

// %hook NSFileManager
// - (NSURL *)containerURLForSecurityApplicationGroupIdentifier:(NSString *)groupIdentifier {
//     NSURL *documentsURL = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
//     NSLog(@"k2ge3l | changed_path : %@", documentsURL);
//     // Sep  2 19:57:04 iphone7 LINE(k2ge3.dylib)[2244] <Notice>: k2ge3 | path : file:///private/var/mobile/Containers/Shared/AppGroup/811EFB0C-B162-4B37-A410-5ABFEC7470B8/
//     return [documentsURL URLByAppendingPathComponent:@"AppGroup"];
// }
// %end



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

// %ctor {
//     NSLog(@"k2ge3 | Loaded!");
//     // -- image path check --
//     // if (MSGetImageByName("/private/var/containers/Bundle/Application/62AD9C49-6D54-46A9-AB82-5DE046B19E9E/LINE.app/LINE")){
//     if (MSGetImageByName("@executable_path")){
//         NSLog(@"k2ge3 | Image path ok");
//     }
//     // -- findsymbol --
//     void* func_addr = (void*)MSFindSymbol(NULL, "LineTalkService_sendChatChecked");
//     if (func_addr){
//         NSLog(@"k2ge3 | addr = %p", func_addr);
//     } else {
//         NSLog(@"k2ge3 | addr not found");
//     }
//     // -- dlsym --
//     NSString *appPath = [NSString stringWithFormat: @"%@%@", [[NSBundle mainBundle] bundlePath], @"/LINE"];
//     NSLog(@"k2ge3 | %@", appPath);
//     void* handle = dlopen([appPath UTF8String], RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
//     if (handle){
//         NSLog(@"k2ge3 | Handle ok !!");
//         void* symbol = dlsym(handle,"LineTalkService_sendChatChecked");
//         if (symbol){
//             NSLog(@"k2ge3 | addr = %p !!", symbol);
//             MSHookFunction((void *)symbol,(void*)sendChatChecked, NULL);
//         } else {
//             NSLog(@"k2ge3 | addr not found ;;");
//         }
//     } else {
//         NSLog(@"k2ge3 | Handle failed ;;");
//     }
// }
