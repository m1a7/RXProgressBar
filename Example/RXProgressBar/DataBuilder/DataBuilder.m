//
//  DataBuilder.m
//  RXProgressBar_Example
//
//  Created by Uber on 10/03/2018.
//  Copyright © 2018 m1a7. All rights reserved.
//

#import "DataBuilder.h"

// Model of Instruction
#import <RXProgressBar/RXInstructionModel.h>
#import <RXProgressBar/RXInstructionImgModel.h>

@implementation DataBuilder

+ (NSArray<id<RXInstructionModelProtocol>>*) createPumkinInstruction
{
    NSArray<id<RXInstructionModelProtocol>>* arrStepByStep = @[
                                                               
                                                               
           [[RXInstructionModel alloc]initWithInstruction:@"1. Set up your workspace: Line a sturdy table with flattened grocery bags,"
            "newsprint, or butcher paper. Have your permanent marker, carving tools, and bowls nearby."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/75267c5078e282a863da2a47c790abae708ce723?w=800&fit=max"                   andTitle:@"Step 1"],
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/df80bed60d75b5f804ca8dc69bd739dacf71ec7d?auto=format&q=45&w=800.0&fit=max&cs=strip" andTitle:@"Step 2"]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"2. Draw your design: After you've determined the best side of your pumpkin for a face,"
            "use the permanent marker to sketch out eyes, a nose, and a toothy grin."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/ab3c875abbd4bae1fbf0c8170c90336c285df7f7?w=800&fit=max"
                                                                                             andTitle:@""]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"3. Draw your lid: Outline a circular lid around the pumpkin stem, about 5 to 6 inches in diameter."
            "Add a notch in the back if you like — this makes it easier to line up."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/08968f4714fd7285c6f6ed7e37f7e2370283cf97?w=800&fit=max"  andTitle:@"Шаг 1"]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"4. Cut out the pumpkin lid: With a slim pumpkin carving knife (the carving tool with a toothed blade like a mini-saw)"
            "or serrated knife, cut along the outline of your pumpkin lid. Make sure you slice through the pumpkin at a 45-degree"
            "inward angle, so you'll be able to replace the lid without it falling in."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/fa181109bc47f1ec972898a8ff2b319a0d666dde?w=800&fit=max"  andTitle:@"Шаг 1"],
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/0fa0214217b125f9915edca3a6019a1b73982c55?w=800&fit=max"  andTitle:@"Шаг 2"]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"5. Remove the pumpkin seeds: The seeds are all attached to the pumpkin and each other by thin strings."
            "Grab the big bunches of seeds with your hands and place them in one of the bowls, to be cleaned later."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/d8300abbd5a78aa7c91111ca16d9a035d973a918?w=800&fit=max"   andTitle:@"Шаг 1"]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"6. Scoop out the insides of the pumpkin: Using a ladle or the scraper that came with your kit"
            "(or a metal spoon if you don't have this tool), clean out the inside of the pumpkin until no stringy"
            "bits remain. Discard the pumpkin guts in the second bowl."
            
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/e77aed1083c3b89a96cbd1e005c02e01ac839ced?w=800&fit=max"                   andTitle:@"Шаг 1"]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"7. Wipe off the pumpkin: Use the kitchen towel to wipe off the outside of the pumpkin so that it will be easier and safer to carve."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/f18f9f43c9c5a97682b7a56ea70daa0af4eac8f0?w=800&fit=max"
                                                                                             andTitle:@"One of the biggest issues"]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"8. Cut out the design: Make straight cuts into your pumpkin along the lines of your design, removing"
            "the pieces and discarding them in the refuse bowl."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/d84ed7881373ac9df5acaa6dafb65ffcf7b48b50?w=800&fit=max"  andTitle:@"Шаг 1"]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"9. Clean up the details: Go back in and scrape out any stringy pieces or jagged lines with"
            "an X-ACTO knife or the wire tool from your carving kit. You can also scrape off the marker"
            "lines while you're at it, though they won't be visible in the darkness of night."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/00729cd8a1183fc083c579254fcef51ab0cd8a81?w=800&fit=max"   andTitle:@"Шаг 1"]
                                                            ]],
           
           [[RXInstructionModel alloc]initWithInstruction:@"10. Light your pumpkin: Insert a tea light candle in the bottom of your pumpkin. Use a long match or lighter to light the pumpkin and replace the lid. Tip: If you're having trouble lighting the candle, try going through the mouth of the jack-o'-lantern instead of the top."
                                              withImgsURL:@[
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://atmedia.imgix.net/3c817724c670a40b5750ebe29c9261c90a6e7867?w=800&fit=max"  andTitle:@"Шаг 1"],
                                                            [[RXInstructionImgModel alloc]initWithURL:@"https://media.giphy.com/media/KYFirz0NgfFidUtiYV/giphy.gif"                        andTitle:@"Шаг 1"]
                                                            ]
                                                                ]];
    return arrStepByStep;
}


+ (NSArray<id<RXInstructionModelProtocol>>*) createTomAndJerryInstruction
{
    
    NSArray<id<RXInstructionModelProtocol>>* arrStepByStep = @[
            
       [[RXInstructionModel alloc] initWithInstruction:@"1. Feeling Confident in Your Dancing \nSmile and have fun."
                                                        "The best way to avoid being embarrassed on the dance floor"
                                                        "is to appear confident, even if you are not. "
                                        withMixArrImgs:@[
                                                           [NSData dataWithContentsOfFile:  [[NSBundle mainBundle] pathForResource: @"tomJerry1" ofType: @"gif"]]
                                                         ]],

       [[RXInstructionModel alloc] initWithInstruction:@"2. Don’t drink too much. A drink or two can help to loosen you"
                                                        "up and give you enough confidence to hit the dance floor."
                                                        "However, if you get too drunk, you may actually end up embarrassing yourself."
                                        withMixArrImgs:@[
                                                         [NSData dataWithContentsOfFile:  [[NSBundle mainBundle] pathForResource: @"tomJerry2" ofType: @"gif"]]
                                                         ]],

       [[RXInstructionModel alloc]initWithInstruction:@"3. Try dancing by yourself. To get over your dancing jitters,"
                                                       "practice your moves by yourself in a space that is free of any judgement."
                                           withImgsURL: @[
                                                           [[RXInstructionImgModel alloc]initWithURL:@"https://media.giphy.com/media/7EO6aesOFXxZ5FY5xo/giphy.gif"  andTitle:@"Шаг 1"]
                                                         ]],

       
       [[RXInstructionModel alloc] initWithInstruction:@"4. Dance with a partner or group of friends. You are more likely"
                                                        "to feel comfortable dancing if you are surrounded by your friends."
                                        withMixArrImgs:@[
                                                         [NSData dataWithContentsOfFile:  [[NSBundle mainBundle] pathForResource: @"tomJerry4" ofType: @"gif"]]
                                                         ]],

       [[RXInstructionModel alloc] initWithInstruction:@"5.  Identify the beat of a song. In order to dance to music, you need"
                                                        "to be able to identify the beat. Listen to a song and try and tap your"
                                                        "foot or clap your hands along to the beat."
                                        withMixArrImgs:@[
                                                         [NSData dataWithContentsOfFile:  [[NSBundle mainBundle] pathForResource: @"tomJerry5" ofType: @"gif"]]
                                                         ]]
       
      ];
    
    return arrStepByStep;
}
@end
