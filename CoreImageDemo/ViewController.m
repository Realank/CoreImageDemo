//
//  ViewController.m
//  CoreImageDemo
//
//  Created by Realank on 16/5/30.
//  Copyright © 2016年 Relaank. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage* image = [UIImage imageNamed:@"face"];
    UIImageView *resultImageView = [[UIImageView alloc] initWithImage: image];
    
    [resultImageView setFrame:CGRectMake(0, 100, 300,300)];
    [self.view addSubview:resultImageView];
    
    CIImage* ciimage = [CIImage imageWithCGImage:image.CGImage];
    ciimage = [self ciImageByUsingSepiaFilter:ciimage];
    
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:ciimage fromRect:[ciimage extent]];
    image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    resultImageView.image = image;
}
//四周阴影
-(CIImage*)ciImageByUsingVignetteFilter:(CIImage*)ciImage{
    CIFilter* vignatte = [CIFilter filterWithName:@"CIVignette"];
    [vignatte setValue:@3.0 forKey:@"inputIntensity"];
    [vignatte setValue:@2.0 forKey:@"inputRadius"];
    
    [vignatte setValue:ciImage forKey:kCIInputImageKey];
    ciImage = vignatte.outputImage;
    return ciImage;
}
//做旧效果
-(CIImage*)ciImageByUsingSepiaFilter:(CIImage*)ciImage{
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [sepiaFilter setValue:@(0.5) forKey:@"inputIntensity"];

    [sepiaFilter setValue:ciImage forKey:kCIInputImageKey];
    ciImage = sepiaFilter.outputImage;
    return ciImage;
}
@end
