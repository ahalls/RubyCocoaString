//
//  RCGsubTests.m
//  RubyCocoaString
//
//  Created by Parker Wightman on 12/24/12.
//  Copyright (c) 2012 Parker Wightman Inc. All rights reserved.
//

#import "RCGsubTests.h"
#import "NSString+RubyCocoaString.h"

@implementation RCGsubTests

- (void) testGsubWithStringWithMatchingStrings {
	NSString *initialStr = @"Foo foo";
	
	NSString *result = [initialStr gsub:@"(Foo|foo)" withString:@"bar"];
	
	STAssertTrue([result isEqualToString:@"bar bar"], @"gsub:withString: should replace \"Foo foo\" with \"bar bar\"");
}

- (void) testGsubWithBlockWithMatchingStrings {
	NSString *initialStr = @"Foo foo";
	
	__block NSInteger value = 0;
	
	NSString *result = [initialStr gsub:@"(Foo|foo)" withBlock:^NSString *(NSString *str, NSRange range) {
		return [@(value++) stringValue];
	}];
	
	STAssertTrue([result isEqualToString:@"0 1"], @"gsub:withBlock: should replace \"Foo foo\" with \"bar bar\"");
}

- (void) testGsubWithBlockWithLongReplacementStrings {
	NSString *initialStr = @"Foo bar";
	
	NSString *result = [initialStr gsub:@"(Foo|bar)" withBlock:^NSString *(NSString *str, NSRange range) {
		return @"Some really, really long string";
	}];
	
	STAssertTrue([result isEqualToString:@"Some really, really long string Some really, really long string"], @"gsub:withBlock: should replace \"Foo foo\" with really long string");
	
}

- (void) testGsubWithCapitalLetterRange {
	NSString *str = @"fooBARandFOO";
	__block NSInteger count = 0;
	NSString *result = [str gsub:@"[A-Z]+" withBlock:^NSString *(NSString *str, NSRange range) {
		return [@(count++) stringValue];
	}];
	
	STAssertTrue([result isEqualToString:@"foo0and1"], @"gsub:withBlock: fooBARandFOO should become foo0and1");
}

//- (void) testGsubWithBlockWithSimpleKleeneStarExpression {
//	NSString *initialStr = @"hello";
//	
//	NSString *result = [initialStr gsub:@".*" withBlock:^NSString *(NSString *str) {
//		return @"world";
//	}];
//	
//	STAssertTrue([result isEqualToString:@"world"], @"gsub:withBlock: should replace \"Foo foo\" with \"bar bar\"");
//}

@end
