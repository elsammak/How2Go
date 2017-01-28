//
//  MKPolyline+MKPolyline_EncodedString.h
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKPolyline (MKPolyline_EncodedString)
+ (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString;
@end
