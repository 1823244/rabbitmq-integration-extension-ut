﻿
Функция СоздатьУзелIdentification(СсылкаНаОбъект) Экспорт

	// Проверка заполнения делается в вызываемых методах!!!!!!
	//Если СсылкаНаОбъект = Неопределено ИЛИ НЕ ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
	//	Возврат Новый Структура;
	//КонецЕсли;

	Если Перечисления.ТипВсеСсылки().СодержитТип(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат СоздатьУзелIdentification_Перечисления(СсылкаНаОбъект);
		
	ИначеЕсли Справочники.ТипВсеСсылки().СодержитТип(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат СоздатьУзелIdentification_Справочника(СсылкаНаОбъект);
		
	ИначеЕсли Документы.ТипВсеСсылки().СодержитТип(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат СоздатьУзелIdentification_Документа(СсылкаНаОбъект);

	ИначеЕсли ПланыВидовХарактеристик.ТипВсеСсылки().СодержитТип(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат СоздатьУзелIdentification_ПВХ(СсылкаНаОбъект);

	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции


Функция СоздатьУзелIdentification_Перечисления(СсылкаНаОбъект) Экспорт
	
	ОтветСтруктура = Новый Структура("type", "");
	
	Если СсылкаНаОбъект = Неопределено или СсылкаНаОбъект = null Тогда                          
		Возврат ОтветСтруктура;
	КонецЕсли;

	ОтветСтруктура.type = СсылкаНаОбъект.Метаданные().ПолноеИмя();
	
	Если не ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		Возврат ОтветСтруктура;
	КонецЕсли;
	
	ОтветСтруктура.Вставить("Значение", НайтиЗначениеПеречисленияПоПредставлению(СсылкаНаОбъект));
	ОтветСтруктура.Вставить("Представление", Строка(СсылкаНаОбъект));
	
	Возврат ОтветСтруктура;
	
КонецФункции                                         

Функция СоздатьУзелIdentification_Справочника(СсылкаНаОбъект) Экспорт
	
	ОтветСтруктура = Новый Структура("type", "");
	
	Если СсылкаНаОбъект = Неопределено или СсылкаНаОбъект = null Тогда                          
		Возврат ОтветСтруктура;
	КонецЕсли;

	мд = СсылкаНаОбъект.метаданные();
	type = мд.ПолноеИмя();	
	ОтветСтруктура.type = type;
	
	Если не ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		Возврат ОтветСтруктура;
	КонецЕсли;
	
	ОтветСтруктура.Вставить("Ref", Строка(СсылкаНаОбъект.УникальныйИдентификатор()));

	Если type = "Справочник.Валюты" Тогда
		ОтветСтруктура.Вставить("currencyCode", СсылкаНаОбъект.Код);	
		ОтветСтруктура.Вставить("currencyName", СокрЛП(СсылкаНаОбъект.Наименование));	

	ИначеЕсли type = "Справочник.СтавкиНДС" Тогда
		ОтветСтруктура.Вставить("ПеречислениеСтавкаНДС", СоздатьУзелIdentification_Перечисления(СсылкаНаОбъект.ПеречислениеСтавкаНДС));
		
	КонецЕсли;

	
	Возврат ОтветСтруктура;
	
КонецФункции

Функция СоздатьУзелIdentification_Документа(СсылкаНаОбъект) Экспорт
	
	ОтветСтруктура = Новый Структура("type", "");
	
	// может быть пустая ссылка! ее надо типизировать и выгрузить в json
	
	Если СсылкаНаОбъект = Неопределено или СсылкаНаОбъект = null Тогда                          
		Возврат ОтветСтруктура;
	КонецЕсли;
	
	// тип нужен для случая наличия нескольких типов в реквизите
	ОтветСтруктура.type = СсылкаНаОбъект.Метаданные().ПолноеИмя();
		
	Если не ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		Возврат ОтветСтруктура;
	КонецЕсли;

	ОтветСтруктура.Вставить("Ref", Строка(СсылкаНаОбъект.УникальныйИдентификатор()));
	
	// 2023-11-15 не надо добавлять лишние атрибуты. боремся за производительность
	//ОтветСтруктура.Вставить("Number", СсылкаНаОбъект.Номер);
	//ОтветСтруктура.Вставить("Date", XMLСтрока(СсылкаНаОбъект.Дата));
	
	Возврат ОтветСтруктура;
	
КонецФункции

Функция СоздатьУзелIdentification_ПВХ(СсылкаНаОбъект) Экспорт
	
	ОтветСтруктура = Новый Структура("type", "");
	
	Если СсылкаНаОбъект = Неопределено или СсылкаНаОбъект = null Тогда                          
		Возврат ОтветСтруктура;
	КонецЕсли;

	ОтветСтруктура.type = СсылкаНаОбъект.метаданные().ПолноеИмя();
	
	Если НЕ ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		Возврат ОтветСтруктура;
	КонецЕсли;
	
	ОтветСтруктура.Вставить("Ref", Строка(СсылкаНаОбъект.УникальныйИдентификатор()));
	
	
	Возврат ОтветСтруктура;
	
КонецФункции



Функция СоздатьУзелDefinition(СсылкаНаОбъект) Экспорт
	
	Если Перечисления.ТипВсеСсылки().СодержитТип(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат СоздатьУзелDefinition_Перечисления(СсылкаНаОбъект);
		
	ИначеЕсли Справочники.ТипВсеСсылки().СодержитТип(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат СоздатьУзелDefinition_Справочника(СсылкаНаОбъект);
		
	ИначеЕсли Документы.ТипВсеСсылки().СодержитТип(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат СоздатьУзелDefinition_Документа(СсылкаНаОбъект);

	ИначеЕсли ПланыВидовХарактеристик.ТипВсеСсылки().СодержитТип(ТипЗнч(СсылкаНаОбъект)) Тогда
		Возврат СоздатьУзелDefinition_ПВХ(СсылкаНаОбъект);

	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции

Функция СоздатьУзелDefinition_Перечисления(СсылкаНаОбъект) Экспорт
	
	ОтветСтруктура = Новый Структура;
	
	Возврат ОтветСтруктура;
	
КонецФункции                                         

Функция СоздатьУзелDefinition_Справочника(СсылкаНаОбъект) Экспорт
	
	ОтветСтруктура = Новый Структура;
	
	Если НЕ ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		Возврат ОтветСтруктура;
	КонецЕсли;
	
	ОтветСтруктура.Вставить("DeletionMark", СсылкаНаОбъект.ПометкаУдаления);
	
	мд = СсылкаНаОбъект.метаданные();
	
	Если мд.ДлинаКода > 0 Тогда
		ОтветСтруктура.Вставить("Code", СсылкаНаОбъект.Код);
	Иначе 
		ОтветСтруктура.Вставить("Code", "");
	КонецЕсли;
		
	Если мд.ДлинаНаименования > 0 Тогда
		ОтветСтруктура.Вставить("Description", СсылкаНаОбъект.Наименование);
	Иначе 
		ОтветСтруктура.Вставить("Description", "");
	КонецЕсли;
		
	Если мд.Владельцы.Количество() > 0 Тогда
		Попытка		
			owner = СоздатьУзелIdentification_Справочника(СсылкаНаОбъект.Владелец);
			ОтветСтруктура.Вставить("Owner", owner);
		Исключение
		    
		КонецПопытки;		
	КонецЕсли;
	
	ОтветСтруктура.Вставить("Predefined", Ложь);
	Если СсылкаНаОбъект.Предопределенный Тогда
		ОтветСтруктура.Вставить("PredefinedName", СокрЛП(СсылкаНаОбъект.ИмяПредопределенныхДанных));
		ОтветСтруктура.Вставить("Predefined", Истина);
	КонецЕсли;

	Если мд.Иерархический = Истина Тогда
		ОтветСтруктура.Вставить("isFolder", СсылкаНаОбъект.ЭтоГруппа);
		parent = СоздатьУзелIdentification_Справочника(СсылкаНаОбъект.Родитель);
		ОтветСтруктура.Вставить("Parent", parent);
	Иначе 
		ОтветСтруктура.Вставить("isFolder", false);
	КонецЕсли;
	
	
	
	Возврат ОтветСтруктура;
	
КонецФункции

Функция СоздатьУзелDefinition_Документа(СсылкаНаОбъект) Экспорт
	
	ОтветСтруктура = Новый Структура;
	
	Если НЕ ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		Возврат ОтветСтруктура;
	КонецЕсли;
	
	ОтветСтруктура.Вставить("DeletionMark", СсылкаНаОбъект.ПометкаУдаления);
	
	ОтветСтруктура.Вставить("isPosted", СсылкаНаОбъект.Проведен);
	
	ОтветСтруктура.Вставить("Number", СсылкаНаОбъект.Номер);
	ОтветСтруктура.Вставить("Date", XMLСтрока(СсылкаНаОбъект.Дата));
	
	Возврат ОтветСтруктура;
	
КонецФункции

Функция СоздатьУзелDefinition_ПВХ(СсылкаНаОбъект) Экспорт
	
	ОтветСтруктура = Новый Структура;
	
	Если НЕ ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		Возврат ОтветСтруктура;
	КонецЕсли;
	
	ОтветСтруктура.Вставить("DeletionMark", СсылкаНаОбъект.ПометкаУдаления);
	
	мд = СсылкаНаОбъект.метаданные();
	
	Если мд.ДлинаКода > 0 Тогда
		ОтветСтруктура.Вставить("Code", СсылкаНаОбъект.Код);
	Иначе 
		ОтветСтруктура.Вставить("Code", "");
	КонецЕсли;
		
	Если мд.ДлинаНаименования > 0 Тогда
		ОтветСтруктура.Вставить("Description", СсылкаНаОбъект.Наименование);
	Иначе 
		ОтветСтруктура.Вставить("Description", "");
	КонецЕсли;

	Если мд.Иерархический = Истина Тогда
		ОтветСтруктура.Вставить("isFolder", СсылкаНаОбъект.ЭтоГруппа);
		parent = СоздатьУзелIdentification_Справочника(СсылкаНаОбъект.Родитель);
		ОтветСтруктура.Вставить("Parent", parent);
	Иначе 
		ОтветСтруктура.Вставить("isFolder", false);
	КонецЕсли;
	
	
	Возврат ОтветСтруктура;
	
КонецФункции



#Область Служебные

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиЗначениеПеречисленияПоПредставлению(ЗначениеПеречисления)
	
	МД = ЗначениеПеречисления.Метаданные().ЗначенияПеречисления;
	Для каждого Значение Из МД Цикл
		Если Значение.Синоним = Строка(ЗначениеПеречисления) Тогда
			Возврат Значение.Имя;
		КонецЕсли;
	КонецЦикла;
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

   
