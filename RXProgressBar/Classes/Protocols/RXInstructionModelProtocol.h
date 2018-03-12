//
//  RXInstructionModelProtocol.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>
#import "RXInstructionImgModelProtocol.h"


/*
{
    instruction : "Помойте тыкву",
    images : [
              {
                  "url"     : "https:///site.com/1.jpg",
                  "title"   : "Тыква ",
                  "summary" : "Она должна быть якрой.",
                  "Credit"  : "Помой и вытри на сухо тыкву"
              },
              
              {
                  "url"     : "https:///site.com/2.jpg",
                  "title"   : "Тыква ",
                  "summary" : "Она должна быть якрой.",
                  "Credit"  : "Помой и вытри на сухо тыкву"
              }
              ]
}
*/

/*
   Этот протокол - модилирование того что может прийти в RXMiddleCell.
   По факту в ячейки есть label (в json'e это поле instruction).
 
   И массив фотографий (каждая фото объект отвечающий протоколу RXInstructionImgModelProtocol).
   Это протокол нужен для того, что бы была возможность поддержки подписи (title/summary/сredit)
   под фотографией.
 
   /////
 
   Данный протокол нужен при создании условий для работы RXProgressBar.
   Точнее RXProgressBar пройдется по массиву который ему передали через метод -createVMfromModelsArray.
   В нем найдет все объекты котрые поддеживают данный проткол и создадим с помощью них ВьюМодели
   RXMiddleViewModelCell.
 */

@protocol RXInstructionModelProtocol <NSObject>

@required
@property (nonatomic, strong) NSString* instruction;
@property (nonatomic, strong) NSArray<id< RXInstructionImgModelProtocol >>* imagesURL;
@end
