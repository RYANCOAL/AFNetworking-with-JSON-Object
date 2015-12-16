//
//  AFNetworking-studyTestsJSONTests.m
//  AFNetworking-study
//
//  Created by Steven Poon on 11/12/2015.
//  Copyright © 2015 Raymond Lai. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AFNetworking_studyTestsJSONTests : XCTestCase


@end


@implementation AFNetworking_studyTestsJSONTests


- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNSDictionarytoNSString{
    NSDictionary *inventory = @{
                                @"a":@{
                                        @"fname" : @"abc",
                                        @"lname" : @"def"
                                        },
                                @"b":@{
                                        @"fname" : @"ghi",
                                        @"lname" : @"jkl"
                                        }
                                };
    
    NSString *changestring = @"{\"a\":{\"fname\":\"abc\",\"lname\":\"def\"},\"b\":{\"fname\":\"ghi\",\"lname\":\"jkl\"}}";
    
    
    NSData *data;
    NSError *error;
    data = [NSJSONSerialization dataWithJSONObject:inventory options:0 error:&error];
    
    if(error!=nil){
        NSLog(@"this is error %@",error);
    }
    
    NSString *newstring = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"this is newstring %@",newstring);
    
    XCTAssert([changestring isEqualToString:newstring]);
    
}

- (void)testjsonescapetest{
    /*NSString *newstring = @"{\"a\":123,\"b\":\"4 5 \\n\\n6\"}";
    NSData *data = [newstring dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"this is new dict %@",dict);*/
    
    NSArray *oarray = [NSArray arrayWithObjects:
                       @"{\"a\":123,\"b\":\"4 5 \\b 6\"}",
                       @"{\"a\":123,\"b\":\"4 5 \\f 6\"}",
                       @"{\"a\":123,\"b\":\"4 5 \\n 6\"}",
                       @"{\"a\":123,\"b\":\"4 5 \\r 6\"}",
                       @"{\"a\":123,\"b\":\"4 5 \\t 6\"}",
                       @"{\"a\":123,\"b\":\"4 5 \\\" 6\"}",
                       @"{\"a\":123,\"b\":\"4 5 \\\\ 6\"}",
                       nil];
    
    
    
    for(int i = 0;i < oarray.count;i++){
        NSString *newabc = oarray[i];
        NSData *data = [newabc dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"this is new dict %@",dict);
        NSLog(@"this is new dict %@",[dict objectForKey:@"b"]);
    }
    

    
}

- (void)testNSStringtoNSDictionary{
    
    NSString *changestring = @"{\"a\":{\"fname\":\"abc\",\"lname\":\"def\"},\"b\":{\"fname\":\"ghi\",\"lname\":\"jkl\"}}";
    NSDictionary *inventory = @{
                                @"a":@{
                                        @"fname" : @"abc",
                                        @"lname" : @"def"
                                        },
                                @"b":@{
                                        @"fname" : @"ghi",
                                        @"lname" : @"jkl"
                                        }
                                };
    
    NSData *data = [changestring dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSDictionary *dict;
    NSError *error;
    dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSLog(@"this is dict %@",dict);
    
    XCTAssert([dict isEqualToDictionary:inventory]);
    
}

- (void)testSupportEmptyObject {
    
    NSString *testEmpty = @"{}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@""]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(0, [dict count]);
    
}

- (void)testSupportEmptyObjectReturn {
    
    NSDictionary *dict = @{};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{}";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testSupportSimpleObjectStringvalue {
    
    NSString *testEmpty = @"{\"v\":\"1\"}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@"1"]);

}

- (void)testSupportSimpleObjectStringvalueReturn {
    
    NSDictionary *dict = @{@"v":@"1"};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"v\":\"1\"}";
    XCTAssert([testEmpty isEqual:testabc]);

}

- (void)testSpaceTester {
    NSString *testEmpty = @"{\"v\":\"1\"\r\n}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@"1"]);
}

- (void)testSupportSimpleObjectIntValue {
    NSString *testEmpty = @"{\"v\":1}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@1]);

}

- (void)testSupportSimpleObjectIntValueReturn {
    NSDictionary *dict = @{@"v":@1};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"v\":1}";
    XCTAssert([testEmpty isEqual:testabc]);
}

- (void)testSupportSimpleQuoteInString {
    NSString *testEmpty = @"{\"v\":\"ab\'c\"}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@"ab\'c"]);
    
}

- (void)testSupportSimpleQuoteInStringReturn {
    
    NSDictionary *dict = @{@"v":@"ab\'c"};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"v\":\"ab\'c\"}";
    XCTAssert([testEmpty isEqual:testabc]);
}

- (void)testSupportSimpleObjectFloatValue {
    
    NSString *testEmpty = @"{\"PI\":3.141E-10}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"PI"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    NSNumber *number = [dict objectForKey:@"PI"];
    NSNumber *number1 = [[NSDecimalNumber alloc] initWithString:@"3.140e-10"];
    NSNumber *number2 = [[NSDecimalNumber alloc] initWithString:@"3.142e-10"];
    XCTAssertEqual([number compare: number1],1);
    XCTAssertEqual([number compare: number2],-1);
    
}

- (void)testSupportSimpleObjectFloatValueReturn {
    
    NSDictionary *dict = @{@"PI":@3.141E-10};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"PI\":3.141e-10}";
    XCTAssert([testEmpty isEqual:testabc]);
}

- (void)testSupportlowcaseObjectFloatValue {
    
    NSString *testEmpty = @"{\"PI\":3.141e-10}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"PI"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    NSNumber *number = [dict objectForKey:@"PI"];
    NSNumber *number1 = [[NSDecimalNumber alloc] initWithString:@"3.14e-10"];
    NSNumber *number2 = [[NSDecimalNumber alloc] initWithString:@"3.142e-10"];
    NSLog(@"this is number%@\n%@\n%@",number,number1,number2);
    XCTAssertEqual([number compare: number1],1);
    XCTAssertEqual([number compare: number2],-1);
    
}

- (void)testLongNumberSupport {
    
    NSString *testEmpty = @"{\"v\":12345123456789}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssertEqual(@12345123456789, [dict objectForKey:@"v"]);
    
}

- (void)testLongNumberSupportReturn {
    
    NSDictionary *dict = @{@"v":@12345123456789};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"v\":12345123456789}";
    XCTAssert([testEmpty isEqual:testabc]);
}

- (void)testBigIntNumberSupport {
    
    NSString *testEmpty = @"{\"v\":123456789123456789123456789}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    NSDecimalNumber *number = [[NSDecimalNumber alloc] initWithString:@"123456789123456789123456789"];
    XCTAssert([number isEqual:[dict objectForKey:@"v"]]);
    
}

- (void)testBigIntNumberSupportReturn {
    
    NSDecimalNumber *number = [[NSDecimalNumber alloc] initWithString:@"123456789123456789123456789"];
    NSDictionary *dict = @{@"v":number};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"v\":123456789123456789123456789}";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testSupportSimpleDigitArray {
    NSString *testEmpty = @"[ 1,2,3,4]";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(4, [dict count]);
    NSArray *array = [dict mutableCopy];
    XCTAssert([[array objectAtIndex:0] isEqual:@1]);
    XCTAssert([[array objectAtIndex:1] isEqual:@2]);
    XCTAssert([[array objectAtIndex:2] isEqual:@3]);
    XCTAssert([[array objectAtIndex:3] isEqual:@4]);
    
    
}

- (void)testSupportSimpleDigitArrayReturn {
    
    NSDictionary *dict = @[ @1,@2,@3,@4];
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"[1,2,3,4]";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testSupportSimpleStringArray {
    NSString *testEmpty = @"[ \"1\",\"2\",\"3\",\"4\"]";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(4, [dict count]);
    NSArray *array = [dict mutableCopy];
    XCTAssert([[array objectAtIndex:0] isEqual:@"1"]);
    XCTAssert([[array objectAtIndex:1] isEqual:@"2"]);
    XCTAssert([[array objectAtIndex:2] isEqual:@"3"]);
    XCTAssert([[array objectAtIndex:3] isEqual:@"4"]);
    
    
}

- (void)testSupportSimpleStringArrayReturn {
    
    NSDictionary *dict = @[ @"1",@"2",@"3",@"4"];
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"[\"1\",\"2\",\"3\",\"4\"]";;
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testArrayOfEmptyObject {
    
    NSString *testEmpty = @"[ { }, { },[]]";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(3, [dict count]);
    NSArray *array = [dict mutableCopy];
    NSLog(@"this is new class %@",[[array objectAtIndex:0] class]);
    NSLog(@"this is new class %@",[[array objectAtIndex:1] class]);
    NSLog(@"this is new class %@",[[array objectAtIndex:2] class]);
    XCTAssert([[array objectAtIndex:0] isEqual:@{ }]);
    XCTAssert([[array objectAtIndex:1] isEqual:@{ }]);
    XCTAssert([[array objectAtIndex:2] isEqual:@[]]);

    
    
}

- (void)testArrayOfEmptyObjectReturn {
    
    NSDictionary *dict = @[ @{ }, @{ },@[]];
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"[{},{},[]]";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testSupportLowercaseUnicodeText {
    
    NSString *testEmpty = @"{\"v\":\"\\u2000\\u20ff\"}";
    NSLog(@"this is new testEmpty %@",testEmpty);
    NSLog(@"this is new testEmpty2 %@",@"{\"v\":\"\u2000\u20ff\"}");
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@"\u2000\u20ff"]);
    //@"\\u2000\\u20ff";
    
    
}

- (void)testSupportLowercaseUnicodeTextReturn {
    
    NSDictionary *dict = @{ @"v":@"\u2000\u20ff"};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"v\":\"\u2000\u20ff\"}";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testSupportUppercaseUnicodeText {
    
    NSString *testEmpty = @"{\"v\":\"\\u2000\\u20FF\"}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@"\u2000\u20FF"]);

    
}

- (void)testSupportUppercaseUnicodeTextReturn {
    
    NSDictionary *dict = @{ @"v":@"\u2000\u20FF"};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"v\":\"\u2000\u20FF\"}";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testSupportChineseUnicodeText {
    
    NSString *testEmpty = @"{\"v\":\"你老豆\"}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@"你老豆"]);
    
}

- (void)testSupportJapaneseUnicodeText {
    
    NSString *testEmpty = @"{\"v\":\"初めまして\"}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@"初めまして"]);
    
}

- (void)testSupportSpeicalUnicodeText {
    
    NSString *testEmpty = @"{\"v\":\"\\uD83E\\uDD84\"}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssert([[dict objectForKey:@"v"] isEqual:@"🦄"]);
    NSString *abc = @"\\Ud83e\\Udd84";
    NSLog(@"this is new string %@", abc);
    abc = [abc substringFromIndex:0];
    //abc = [abc substringFromIndex:7];
    NSLog(@"this is new string %@", abc);
    

           
    
    
    
}



- (void)testSupportNonProtectedtext {
    
    NSString *testEmpty = @"{\"a\":\"hp:\\/\\/foo\"}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"a"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
   
    
}

- (void)testtestSupportNonProtectedtextReturn {
    
    NSDictionary *dict = @{ @"a":@"hp://foo"};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"a\":\"hp:\\/\\/foo\"}";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testSupportnull {
    
    NSString *testEmpty = @"{ \"a\":null}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"a"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    
}

- (void)testSupportnullReturn {
    
    NSDictionary *dict = @{@"a": [NSNull null]};
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"a\":null}";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testSupportBoolean {
    
    NSString *testEmpty = @"{ \"a\":true}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"a"]);
    XCTAssertNotNil(dict);
    NSLog(@"this is new count %lu", (unsigned long)[dict count]);
    XCTAssertEqual(1, [dict count]);
    XCTAssertEqual([dict objectForKey:@"a"],@YES);
    
}

- (void)testSupportBooleanReturn {
    
    NSDictionary *dict = @{@"a": @YES};
    NSLog(@"this is new  kjkjlk dict %@", [[dict objectForKey:@"a"] class]);
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"a\":true}";
    XCTAssert([testEmpty isEqual:testabc]);
    
}

- (void)testDoublePrecisionFloatingPoint {
    
    NSString *testEmpty = @"{\"v\":1.7976931348623157E308}";
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[testEmpty dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSLog(@"this is new dict %@",dict);
    NSLog(@"this is new dict %@", [dict objectForKey:@"v"]);
    XCTAssertNotNil(dict);
    XCTAssertEqual(1, [dict count]);
    NSNumber *number = [dict objectForKey:@"v"];
    NSNumber *number1 = [NSNumber numberWithDouble:1.7976931348623150e+308];
    //NSNumber *number2 = [NSNumber numberWithDouble:1.7976931348623157e+308];
    NSLog(@"this is number%@\n%@",number,number1);
    XCTAssertEqual([number compare: number1],1);
    //XCTAssertEqual([number compare: number2],-1);
    
    }

- (void)testDoublePrecisionFloatingPointReturn {
    
    NSDictionary *dict = @{@"v":@1.7976931348623157E308};
    NSLog(@"this is new  kjkjlk dict %@", [[dict objectForKey:@"a"] class]);
    NSError *error;
    NSString *testEmpty = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error] encoding:NSUTF8StringEncoding];
    NSLog(@"this is new string %@",testEmpty);
    XCTAssertNotNil(testEmpty);
    NSString *testabc = @"{\"v\":1.797693134862316e+308}";
    XCTAssert([testEmpty isEqual:testabc]);
    
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
