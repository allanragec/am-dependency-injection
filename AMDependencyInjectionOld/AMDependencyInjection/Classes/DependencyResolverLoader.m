//
//  DependencyResolverLoader.m
//  DependencyResolver
//
//  Created by Allan Barbosa De Melo on 26/04/24.
//

#import "DependencyResolverLoader.h"
#import <AMDependencyInjection/AMDependencyInjection-Swift.h>
#import <objc/runtime.h>

@implementation DependencyResolverLoader

+ (void)load
{
    NSLog(@"Load Dependency Resolver");
    [LoaderUtils injectDependencies];
    [LoaderUtils checkAllContainers];
}

@end
