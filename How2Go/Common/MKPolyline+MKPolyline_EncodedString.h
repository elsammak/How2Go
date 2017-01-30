//
//  MKPolyline+MKPolyline_EncodedString.h
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// Using this class to convert polyline to MKPolyline.
#import <MapKit/MapKit.h>

@interface MKPolyline (MKPolyline_EncodedString)
/**
 Convert encoded polyline to MKPolyine object.
 
 - parameter encodedString: The encoded Polyline.
 
 - returns: MKPolyline object.
 */
+ (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString;
@end
