/*
     File: DragDropImageView.h
 Abstract: Custom subclass of NSImageView with support for drag and drop operations.
  Version: 1.1
 
 Copyright (C) 2011 Apple Inc. All Rights Reserved.
 
 */

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@protocol DragDropImageViewDelegate <NSObject>
- (void)dropComplete:(NSString *)filePath name:(NSString *)filename;
- (void)dragComplete:(NSString *)filePath name:(NSString *)filename success:(BOOL)success;

@end

/// 可拖拽ImageView
@interface DragDropImageView : NSImageView <NSDraggingSource, NSDraggingDestination, NSPasteboardItemDataProvider>

@property (nonatomic, assign) BOOL highlight;
@property (nonatomic, assign) BOOL allowDrag;
@property (nonatomic, assign) BOOL allowDrop;
@property (nonatomic, assign) IBOutlet id<DragDropImageViewDelegate> delegate;
@property (nonatomic, strong) NSString *path;

- (id)initWithCoder:(NSCoder *)coder;

@end


