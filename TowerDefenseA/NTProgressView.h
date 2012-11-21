//
//  NTProgressView.h
//  ProgressView
//
//  Created by lee jory on 09-10-26.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NTProgressView : UIView {
	// 0 到 1
	float process;
}	
@property(assign) float process;
@end
