//
//  ImageUtility.m
//  StoreSayMerchant
//
//  Created by Abhishek Vashistha on 05/10/16.
//  Copyright © 2016 Deepak Kumar. All rights reserved.
//

#import "ImageUtility.h"
#import <UIKit/UIKit.h>


static ImageUtility* _sharedImageUtility = nil;




@implementation ImageUtility


+(ImageUtility*)sharedImageUtility
{
    
    if (!_sharedImageUtility){
        
        _sharedImageUtility = [[self alloc] init];
        
    }
    
    return _sharedImageUtility;
    
}

-(NSString*)findIfStringIsNULL:(NSString*)str{
    if([str isKindOfClass:[NSNull class]] || str==nil){
        
        str=@"";
    }
    
    return str;
}

-(NSString*)getImageName:(NSString*)image{
    NSString *imagePath;
    NSString *imageName = image;//[[image lastPathComponent] stringByDeletingPathExtension];
    
    if([[image pathExtension]caseInsensitiveCompare:@"jpeg"] == NSOrderedSame){
        
        imagePath=[imageName stringByAppendingFormat:@".jpeg"];
    }
    else if([[image pathExtension]caseInsensitiveCompare:@"jpg"] == NSOrderedSame){
        
        imagePath=[imageName stringByAppendingFormat:@".jpg"];
    }
    else{
        
        imagePath=[imageName stringByAppendingFormat:@".png"];
    }
    
    return imagePath;
}


-(NSData *)getImageFromUrl:(NSString *)urlString{
    
    return [self downloadImage:urlString imageName:[self getImageName:urlString]];
    
    
}

-(NSData *)downloadImage:(NSString*)imagePath imageName:(NSString*)imageName{
    
    NSData *data;
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [docDir stringByAppendingPathComponent:imageName];
    if( [[NSFileManager defaultManager] fileExistsAtPath:foofile]){
        data = [[NSFileManager defaultManager] contentsAtPath:foofile];
        
    }else{
        imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]];
        if([[imageName pathExtension]caseInsensitiveCompare:@"png"]==NSOrderedSame){
            
            NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@",docDir,imageName];
            data = [NSData dataWithData:UIImagePNGRepresentation(image)];
            [data writeToFile:pngFilePath atomically:YES];
            
        }
        else{
            
            NSString *jpegFilePath = [NSString stringWithFormat:@"%@/%@",docDir,imageName];
            data = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];//1.0f = 100% quality
            [data writeToFile:jpegFilePath atomically:YES];
            
        }
    }
    return data;
    
}


-(BOOL)deleteImagesFromDirectory:(NSString*)ext{
    NSString *extension = ext;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
    return true;
}

@end

