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



Функция ВыгрузитьДокументПоСсылке(ДанныеСсылка) Экспорт
	ТипСсылка = Тип(СтрЗаменить(ДанныеСсылка.метаданные().ПолноеИмя(),"Документ.","ДокументСсылка."));
	Если ТипЗнч(ДанныеСсылка) = ТипСсылка Тогда
		Обк = ДанныеСсылка.ПолучитьОбъект(); 
	Иначе 
		Обк = ДанныеСсылка; 
	КонецЕсли;
	Возврат ВыгрузитьОбъектПоСсылке(Обк);
КонецФункции

Функция ВыгрузитьСправочникПоСсылке(ДанныеСсылка) Экспорт
	ТипСсылка = Тип(СтрЗаменить(ДанныеСсылка.метаданные().ПолноеИмя(),"Справочник.","СправочникСсылка."));
	Если ТипЗнч(ДанныеСсылка) = ТипСсылка Тогда
		Обк = ДанныеСсылка.ПолучитьОбъект(); 
	Иначе 
		Обк = ДанныеСсылка; 
	КонецЕсли;
	Возврат ВыгрузитьОбъектПоСсылке(Обк);
КонецФункции

Функция ВыгрузитьПВХПоСсылке(ДанныеСсылка) Экспорт
	ТипСсылка = Тип(СтрЗаменить(ДанныеСсылка.метаданные().ПолноеИмя(),"ПланВидовХарактеристик.","ПланВидовХарактеристикСсылка."));
	Если ТипЗнч(ДанныеСсылка) = ТипСсылка Тогда
		Обк = ДанныеСсылка.ПолучитьОбъект(); 
	Иначе 
		Обк = ДанныеСсылка; 
	КонецЕсли;
	Возврат ВыгрузитьОбъектПоСсылке(Обк);
КонецФункции

Функция ВыгрузитьОбъектПоСсылке(Обк) Экспорт
	
	ТипДокТоЧтоНужно = Ложь;
	Если ТипЗнч(Обк) = Тип("ДокументСсылка.ВзаимозачетЗадолженности") 
		ИЛИ ТипЗнч(Обк) = Тип("ДокументОбъект.ВзаимозачетЗадолженности") Тогда
		ТипДокТоЧтоНужно = Истина;
	
	КонецЕсли;
	
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, Символы.Таб);
	ЗаписьJson = Новый ЗаписьJSON;
	ЗаписьJson.УстановитьСтроку(ПараметрыЗаписиJSON);
	// Это основной объект json-сообщения
	СтруктураОбъекта = Новый Структура;
	СтруктураОбъекта.Вставить("source", "UT");
	СтруктураОбъекта.Вставить("type", Обк.метаданные().ПолноеИмя());
	СтруктураОбъекта.Вставить("datetime", XMLСтрока(ТекущаяДатаСеанса()));
	identification = СоздатьУзелIdentification(Обк.Ссылка);
	СтруктураОбъекта.Вставить("identification", identification);
	//	DEFINITION
	definition = СоздатьУзелDefinition(Обк.Ссылка);
	Для каждого Реквизит Из Обк.метаданные().СтандартныеРеквизиты Цикл
		РеквизитИмя = Реквизит.Имя;
		РеквизитЗначение = Обк[РеквизитИмя];
		Если ТипЗнч(РеквизитЗначение) = Тип("Булево") или ТипЗнч(РеквизитЗначение) = Тип("Строка") или ТипЗнч(РеквизитЗначение) = Тип("Число")
			или ТипЗнч(РеквизитЗначение) = Тип("Дата") или ТипЗнч(РеквизитЗначение) = Тип("Неопределено") Тогда
			definition.Вставить(РеквизитИмя, XMLСтрока(РеквизитЗначение));	
		Иначе		
			definition.Вставить(РеквизитИмя, СоздатьУзелIdentification(РеквизитЗначение));	
		КонецЕсли;	
	КонецЦикла;
	Для каждого Реквизит Из Обк.метаданные().Реквизиты Цикл
		РеквизитИмя = Реквизит.Имя;
		РеквизитЗначение = Обк[РеквизитИмя];
		Если ТипЗнч(РеквизитЗначение) = Тип("Булево") или ТипЗнч(РеквизитЗначение) = Тип("Строка") или ТипЗнч(РеквизитЗначение) = Тип("Число")
			или ТипЗнч(РеквизитЗначение) = Тип("Дата") или ТипЗнч(РеквизитЗначение) = Тип("Неопределено") Тогда
			definition.Вставить(РеквизитИмя, XMLСтрока(РеквизитЗначение));	
		Иначе		
			definition.Вставить(РеквизитИмя, СоздатьУзелIdentification(РеквизитЗначение));	
		КонецЕсли;	
	КонецЦикла;
	
	Для каждого ИмяТЧ Из Обк.метаданные().ТабличныеЧасти Цикл
		ИмяТабЧасти = ИмяТЧ.Имя;
		ТЧ_Документа = Новый Массив;
		Для каждого стрк из Обк[ИмяТабЧасти] Цикл
			НовСтр = Новый Структура;
			Для каждого РеквизитТЧ из ИмяТЧ.Реквизиты Цикл
				РеквизитИмя = РеквизитТЧ.Имя;
				РеквизитЗначение = стрк[РеквизитТЧ.Имя];
				Если ТипЗнч(РеквизитЗначение) = Тип("Булево") или ТипЗнч(РеквизитЗначение) = Тип("Строка") или ТипЗнч(РеквизитЗначение) = Тип("Число")
					или ТипЗнч(РеквизитЗначение) = Тип("Дата") или ТипЗнч(РеквизитЗначение) = Тип("Неопределено") Тогда
					НовСтр.Вставить(РеквизитИмя,XMLСтрока(РеквизитЗначение));
				Иначе
					НовСтр.Вставить(РеквизитИмя,СоздатьУзелIdentification(РеквизитЗначение));
				КонецЕсли;
				
				Если (ИмяТабЧасти = "ДебиторскаяЗадолженность" ИЛИ ИмяТабЧасти = "КредиторскаяЗадолженность")
						И РеквизитИмя = "ОбъектРасчетов" И ТипДокТоЧтоНужно Тогда
					мРеквизитыОбъекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(РеквизитЗначение, "Объект, Партнер, Организация, Контрагент, Договор");
					НовСтр.Вставить("Объект",			СоздатьУзелIdentification(мРеквизитыОбъекта.Объект));
					НовСтр.Вставить("ОбъектПартнер",			СоздатьУзелIdentification(мРеквизитыОбъекта.Партнер));
					НовСтр.Вставить("ОбъектОрганизация",		СоздатьУзелIdentification(мРеквизитыОбъекта.Организация));
					НовСтр.Вставить("ОбъектКонтрагент",		СоздатьУзелIdentification(мРеквизитыОбъекта.Контрагент));
					НовСтр.Вставить("ОбъектДоговор",			СоздатьУзелIdentification(мРеквизитыОбъекта.Договор));
				КонецЕсли;
				
			КонецЦикла;
			ТЧ_Документа.Добавить(НовСтр);
		КонецЦикла;
		definition.Вставить("ТЧ"+ИмяТЧ.Имя, ТЧ_Документа);
	КонецЦикла;
	
	//------------------------------------------------------ ФИНАЛ
	СтруктураОбъекта.Вставить("definition", definition);
	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
	json = ЗаписьJson.Закрыть();
	
	Возврат json;
КонецФункции


// НЕ ИСПОЛЬЗОВАТЬ НАПРЯМУЮ (по-возможности). Вместо этого - ВыполнитьЭкспорт_ГуидовНоменклатуры() и другие
// Выгружает произвольные объекты json из массива
//
// Параметры:
//	МассивОбъектовJson	- массив - элементами являются строки, json-объекты
//	RoutingKey - строка - требуется явное указание ключа
//
Процедура ВыполнитьЭкспорт_СписокJsonИзМассива(МассивОбъектовJson, RoutingKey) Экспорт
	
	ИмяСобытияЖР = "ЭкспортJsonИзМассива";
	
	ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,
	"Запуск" );
	
	ВремяНач = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	Если ПараметрыСеанса.РаботаСВнешнимиРесурсамиЗаблокирована Тогда
		
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
		"Экспорт не выполнен, т.к. ПараметрыСеанса.РаботаСВнешнимиРесурсамиЗаблокирована = Истина" );
		
		Возврат;
		
	КонецЕсли;
	
	ИмяТочкиОбмена = Константы.ксп_ТочкаОбмена.Получить().Наименование;
	
	Если Не ЗначениеЗаполнено(ИмяТочкиОбмена) Тогда
		ВызватьИсключение "Константа ксп_ТочкаОбмена не установлена!";
	КонецЕсли;	
	
	Клиент = Вычислить("PinkRabbit.ПолучитьКлиента()");
	
	Для сч = 0 По МассивОбъектовJson.Количество()-1 Цикл
		
		ОбъектJson = МассивОбъектовJson[сч];
		
		ПредставлениеОбъекта = "объект json из массива. индекс: "+строка(сч);
		
		УспешноОпубликован = Ложь;
		Попытка
			Клиент.BasicPublish(ИмяТочкиОбмена, RoutingKey, ОбъектJson, 0, Ложь);
			УспешноОпубликован = Истина;
			
			// для отладки
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,
			"Выполнена публикация для объекта <"+ПредставлениеОбъекта+">");
			
		Исключение
			т = Клиент.GetLastError();
			тт = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,	
			"Ошибка публикации объекта <"+ПредставлениеОбъекта+">. Ошибка PinkRabbitMQ: "+т+символы.ПС+
			"Ошибка 1С: "+тт);
		КонецПопытки;
		
	КонецЦикла;
	
	Клиент = Неопределено;
	
	ВремяКон = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Длительность = ВремяКон - ВремяНач;
	ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,
	"Завершение. Длительность = " + строка(Длительность) + " мс" );
	
КонецПроцедуры

// Параметры
//	НеНайденнаяНоменклатураМассив - массив - элементы: Строка, ГУИД номенклатуры
Процедура ВыполнитьЭкспорт_ГуидовНоменклатуры(НеНайденнаяНоменклатураМассив) Экспорт
	
	Если НеНайденнаяНоменклатураМассив.Количество() > 0 Тогда  
		
		// сформируем json-array
		ЗаписьJson = Новый ЗаписьJson;
		ЗаписьJson.УстановитьСтроку();
		ЗаписатьJSON(ЗаписьJson, НеНайденнаяНоменклатураМассив);
		jsonGoods = ЗаписьJson.Закрыть();
		
		// добавим json-array в массив и выгрузим
		МассивОбъектовJson = Новый Массив;
		МассивОбъектовJson.Добавить(jsonGoods);
		
		Попытка
			ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_СписокJsonИзМассива( МассивОбъектовJson, "goods.guid" );
		Исключение
			т=ОписаниеОшибки();
			ЗаписьЖурналаРегистрации("ИмпортИзУПП", УровеньЖурналаРегистрации.Предупреждение,,,
			"Ошибка экспорта ненайденной номенклатуры из ЕРП в УПП. Подробности: "+т);
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьЭкспорт_ГуидовКонтрагентов(мНеНайденныеКонтрагентыМассив) Экспорт
	
	Если мНеНайденныеКонтрагентыМассив.Количество() = 0 Тогда  
		возврат;
	КонецЕсли;
	
	ЗаписьJson = Новый ЗаписьJson;
	ЗаписьJson.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJson, мНеНайденныеКонтрагентыМассив);
	jsonGoods = ЗаписьJson.Закрыть();
	
	МассивОбъектовJson = Новый Массив;
	МассивОбъектовJson.Добавить(jsonGoods);
	Попытка
		ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_СписокJsonИзМассива( МассивОбъектовJson, "counterparties.guid" );
	Исключение
		т=ОписаниеОшибки();
		ЗаписьЖурналаРегистрации("ИмпортИзУПП", УровеньЖурналаРегистрации.Предупреждение,,,
		"Ошибка экспорта ненайденных контрагентов из ЕРП в УПП. Подробности: "+т);
	КонецПопытки;
	
	
КонецПроцедуры

