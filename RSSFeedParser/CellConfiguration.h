
#ifndef CellConfiguration_h
#define CellConfiguration_h

#import <UIKit/UIKit.h>

/**
 Defines cell state (i.e. whether the cell was selected)
 */
typedef enum {
	kCellNormal,
	kCellExtended
} CellState;

/** 
 Cell configuration which tells the feed converter and feed cell about cell properties
 */
typedef struct {
	CGSize imageSize;
	CGFloat basicHeight;
	CGFloat extendedHeight;
	
	CellState state;
} CellConfiguration;

#endif /* CellConfiguration_h */
