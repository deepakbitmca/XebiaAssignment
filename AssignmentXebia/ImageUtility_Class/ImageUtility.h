//
//  ImageUtility.h
//  StoreSayMerchant
//
//  Created by Abhishek Vashistha on 05/10/16.
//  Copyright © 2016 Deepak Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtility : NSObject

+(ImageUtility*)sharedImageUtility;

-(NSString*)findIfStringIsNULL:(NSString*)str;
-(NSData *)downloadImage:(NSString*)imagePath imageName:(NSString*)imageName;
-(BOOL)deleteImagesFromDirectory:(NSString*)ext;

-(NSString*)getImageName:(NSString*)image;
-(NSData *)getImageFromUrl:(NSString *)urlString;



@end
