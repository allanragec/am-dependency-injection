//
//  LoaderUtils.swift
//  DependencyResolver
//
//  Created by Allan Barbosa De Melo on 26/04/24.
//

import Foundation

@objcMembers
public class LoaderUtils: NSObject {
    @objc
    public static func injectDependencies() {
        let injections = getClasses(p: DependencyInjection.self)
        print("injections \(injections)")
        for injection in injections {
            let injectionName = injection.description()
            guard
                let injection = NSClassFromString(injectionName) as? DependencyInjection.Type else {
                return
            }
            
            injection.inject()
        }
    }
    
    @objc
    public static func checkAllContainers() {
#if DEBUG
        let containers = getClasses(p: ResolverProtocol.self)
        print("containers \(containers)")
        for containerItem in containers {
            let containerName = containerItem.description()
            guard
                let container = NSClassFromString(containerName) as? ContainerResolver.Type else {
                return
            }
            print("checkAllContainers on \(containerName)")
            guard let resolver = containerItem.resolver else { return }
            
            let containerResolver = container.init(resolver: resolver)
            
            do {
                try containerResolver.checkIfDependenciesCanBeResolved()
            }
            catch let error {
                print(error)
            }
        }
#endif
    }
    
    public static func getClasses(p: Protocol)-> [AnyClass] {
        let expectedClassCount = objc_getClassList(nil, 0)
        let allClasses = UnsafeMutablePointer<AnyClass>.allocate(capacity: Int(expectedClassCount))
        let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
        let actualClassCount:Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
        
        var classes = [AnyClass]()
        for i in 0 ..< actualClassCount {
            let currentClass: AnyClass = allClasses[Int(i)]
            if class_conformsToProtocol(currentClass, p) {
                classes.append(currentClass)
            }
        }
        return classes
    }
    
    public static func getSubclasses(_ parentClass: AnyClass) -> [AnyClass] {
        let expectedClassCount = objc_getClassList(nil, 0)
        let allClasses = UnsafeMutablePointer<AnyClass>.allocate(capacity: Int(expectedClassCount))
        let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
        let actualClassCount:Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
        
        var result: [AnyClass] = []
        
        for i in 0..<actualClassCount {
            let superClass: AnyClass = allClasses[Int(i)]
            
            // Don't add the parent class to list of subclasses
            if superClass == parentClass {
                continue
            }
            
            var currentClass: AnyClass? = superClass
            while currentClass != nil && currentClass != parentClass {
                currentClass = class_getSuperclass(currentClass)
            }
            
            if currentClass != nil {
                result.append(superClass)
            }
        }
        
        return result
    }
}
