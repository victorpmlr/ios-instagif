//
//  ANCutColorTable.h
//  GifPro
//
//  Created by Alex Nichol on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANColorTable.h"
#import "ANGifImageFramePixelSource.h"
#import "ANMutableColorArray.h"

@interface ANCutColorTable : ANColorTable {
	BOOL finishedInit;
}

- (id)initWithTransparentFirst:(BOOL)hasAlpha pixelSource:(id<ANGifImageFramePixelSource>)pixelSource;

@end
