//
//  NawlzGLView.m
//  Nawlz
//
//  Created by lukasz karluk on 3/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "NawlzGLView.h"
#import "Defines.h"
#import "FilePath.h"

#define USE_DEPTH_BUFFER 0

@implementation NawlzGLView

@synthesize context, backingWidth, backingHeight, animationTimer;

+ (Class) layerClass 
{
	return [CAEAGLLayer class];
}

#pragma mark -
#pragma mark Initialization and Shutdown

//DEBUG_LINE(BOOL glViewExists = NO);

- (id)initWithFrame:(CGRect)aRect
{
	//ASSERT(!glViewExists);
	//DEBUG_LINE(glViewExists = YES);
	
	if ((self = [super initWithFrame:aRect])) {
        // Get the layer
		self.multipleTouchEnabled = YES;
		self.opaque = NO;
		
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = NO;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		
		
		if (!context || ![EAGLContext setCurrentContext:context]) {
			[self release];
			return nil;
		}
		
		animationFrameInterval = 1;
		lastTime = 0.0f;
		
		[self createFramebuffer];
		[self initOpenGL];
		[self clearScreen];	
		
		[ self appInit ];
	}
    return self;
}

/////////////////////////////////////////////////////
//	DESTROY.
/////////////////////////////////////////////////////

- (void)dealloc 
{
	//ASSERT(glViewExists);
	//DEBUG_LINE(glViewExists = NO);
	self.animationTimer = nil;
	
	[ self appKill ];
	
	[self destroyFramebuffer];
	
	if ([EAGLContext currentContext] == context) 
	{
		[EAGLContext setCurrentContext:nil];
	}
	
	[context release];	
	
	[super dealloc];
}

/////////////////////////////////////////////////////
//	INIT YEAH.
/////////////////////////////////////////////////////

- (void)initOpenGL
{
    int w = ofGetWidth();
    int h = ofGetHeight();
    
	glViewport( 0, 0, w, h );
	
    glClearColor( 0.0, 0.0, 0.0, 1.0 );
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    float halfFov, theTan, screenFov, aspect;
    screenFov 		= 60.0f;
    
    float eyeX 		= (float)w / 2.0;
    float eyeY 		= (float)h / 2.0;
    halfFov 		= PI * screenFov / 360.0;
    theTan 			= tanf(halfFov);
    float dist 		= eyeY / theTan;
    float nearDist 	= dist / 10.0;	// near / far clip plane
    float farDist 	= dist * 10.0;
    aspect 			= (float)w/(float)h;
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(screenFov, aspect, nearDist, farDist);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt(eyeX, eyeY, dist, eyeX, eyeY, 0.0, 0.0, 1.0, 0.0);

    //---
    
    glDisable(GL_DEPTH_TEST);
    glEnable(GL_BLEND);
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_VERTEX_ARRAY);
}

/////////////////////////////////////////////////////
//	ANIMATION TIMER.
/////////////////////////////////////////////////////

/*- (void)startAnimation {
 animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(render) userInfo:nil repeats:TRUE];
 }*/
- (void)startAnimation {
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 30.0) * animationFrameInterval) target:self selector:@selector(render) userInfo:nil repeats:YES];
}


- (void)stopAnimation {
    self.animationTimer = nil;
}


- (void)setAnimationTimer:(NSTimer *)newTimer {
    [animationTimer invalidate];
    animationTimer = newTimer;
	
	if (newTimer)
	{
		[[NSRunLoop currentRunLoop] addTimer: animationTimer forMode: NSRunLoopCommonModes];
	}
}

/////////////////////////////////////////////////////
//	RENDER.
/////////////////////////////////////////////////////

#pragma mark -
#pragma mark Drawing

- (void)render {
	
	//DLog("Render GL");
	//NLog(@"%@", self.superview);
	
	if (!self.superview)
	{
		DLog("Failed to delete the gl view after it has been removed from the stage. Feel bad about yourself.");
		[self stopAnimation];
		
		[context release];	
		
		context = nil;
		return;
	}
	
	CFTimeInterval		time;
	float				delta;
	
	// Apple advises to use CACurrentMediaTime() as CFAbsoluteTimeGetCurrent() is synced with the mobile
	// network time and so could change causing hiccups.
	time = CACurrentMediaTime();
	//time = CFAbsoluteTimeGetCurrent();
	delta = (time - lastTime);
	
	
	[self beginRender];
	
    [ self appUpdate ];
    
    glPushMatrix();					// not sure why the GL view is upside down and back to front.
    glTranslatef( 512, 384, 0 );	// anyhoo, this fixes it.
    glRotatef( 180, 0, 0, 1 );		// conduct might have a more elegant solution for this.
    glScalef( -1, 1, 1 );
    glTranslatef( -512, -384, 0 );
    
    [ self appDraw ];
    
    glPopMatrix();
	
	[self endRender];
	
	lastTime = time;
	
}
- (void)clearScreen
{
	[EAGLContext setCurrentContext:context];
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
	
}

- (void)beginRender
{
	[EAGLContext setCurrentContext:context];
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glViewport(0, 0, backingWidth, backingHeight);
	glClear(GL_COLOR_BUFFER_BIT);
}

- (void)endRender
{
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

/////////////////////////////////////////////////////
//	TOUCH HANDLERS.
/////////////////////////////////////////////////////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	//
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	for( int i = 0; i < (int)[touches count]; ++i )
	{
		UITouch* touch				= [ [ touches allObjects ] objectAtIndex : i ];
		CGPoint currentLocation		= [ touch locationInView : self ];
		CGPoint previousLocation	= [ touch previousLocationInView : self ];
		
        [ self appTouchMoved: currentLocation.x : currentLocation.y : i ];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	//
}

/////////////////////////////////////////////////////
//	FRAME BUFFER.
/////////////////////////////////////////////////////

#pragma mark -
#pragma mark OpenGL Framebuffer helper methods

- (BOOL)createFramebuffer 
{	
	glGenFramebuffersOES(1, &viewFramebuffer);
	glGenRenderbuffersOES(1, &viewRenderbuffer);
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) 
	{
		return NO;
	}
	
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	return YES;
}

- (void)destroyFramebuffer 
{
	
	glDeleteFramebuffersOES(1, &viewFramebuffer);
	viewFramebuffer = 0;
	glDeleteRenderbuffersOES(1, &viewRenderbuffer);
	viewRenderbuffer = 0;
	
	if(depthRenderbuffer) {
		glDeleteRenderbuffersOES(1, &depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}

/////////////////////////////////////////////////////////
//  APP METHODS.
/////////////////////////////////////////////////////////

- (void) appInit    {}
- (void) appKill    {}
- (void) appUpdate  {}
- (void) appDraw    {}
- (void) appTouchDown   : (int) x : (int) y : (int) button  {}
- (void) appTouchMoved  : (int) x : (int) y : (int) button  {}
- (void) appTouchUp     : (int) x : (int) y : (int) button  {}

/////////////////////////////////////////////////////
//	TEXTURES.
/////////////////////////////////////////////////////

- (void) loadImage : (NSString*) fileName : (NawlzImage*) imageOut
{
	NSString*	imagePath;
	UIImage*	image;
	
	GLubyte* pixels;
	int imageWidth;
	int imageHeight;
	
	imagePath	= [ FilePath pathForAsset : fileName ];
	image		= [ [ UIImage alloc ] initWithContentsOfFile : imagePath ];
	
	CGContextRef spriteContext;
	CGImageRef	cgImage = image.CGImage;
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(cgImage);
	
	int bytesPerPixel	= CGImageGetBitsPerPixel(cgImage)/8;
	if(bytesPerPixel == 3) bytesPerPixel = 4;
	
	imageWidth	= CGImageGetWidth(cgImage);
	imageHeight	= CGImageGetHeight(cgImage);
	
	pixels			= (GLubyte *) malloc( imageWidth * imageHeight * bytesPerPixel);
	spriteContext	= CGBitmapContextCreate(pixels, imageWidth, imageHeight, CGImageGetBitsPerComponent(cgImage), imageWidth * bytesPerPixel, colorSpace, bytesPerPixel == 4 ? kCGImageAlphaPremultipliedLast : kCGImageAlphaNone);
	
    CGColorSpaceRelease( colorSpace );
    CGContextClearRect( spriteContext, CGRectMake( 0, 0, imageWidth, imageHeight ) );
    
    CGContextDrawImage(spriteContext, CGRectMake(0.0, 0.0, (CGFloat)imageWidth, (CGFloat)imageHeight), cgImage);
	CGContextRelease(spriteContext);
	
	imageOut->width         = imageWidth;
	imageOut->height		= imageHeight;
	imageOut->pixelDepth	= bytesPerPixel;
	imageOut->glType		= GL_LUMINANCE;
	if( bytesPerPixel == 3 )
		imageOut->glType	= GL_RGB;
	if( bytesPerPixel == 4 )
		imageOut->glType	= GL_RGBA;
	imageOut->pixels		= new unsigned char[ imageWidth * imageHeight * bytesPerPixel ];
	
	memcpy( imageOut->pixels, pixels, imageWidth * imageHeight * bytesPerPixel );
	
	free( pixels );
	[ image release ];
}

@end