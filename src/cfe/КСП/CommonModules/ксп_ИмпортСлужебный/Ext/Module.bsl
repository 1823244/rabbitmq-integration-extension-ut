﻿// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиНоменклатуру(УзелНоменклатуры) Экспорт
	
	НоменклатураГУИД = "";
	Если УзелНоменклатуры.Свойство("Ref", НоменклатураГУИД) Тогда
		Возврат Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(НоменклатураГУИД));
	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции

Функция НайтиКоллекциюНоменклатуры(Узел, ВнешняяСистема) Экспорт

	КоллекцияНоменклатуры = Неопределено;
	ГУИД = "";
	Если узел.Свойство("Ref", ГУИД) Тогда
		КоллекцияНоменклатуры = РегистрыСведений.ксп_МэппингСправочникКоллекцииНоменклатуры.ПоМэппингу(ГУИД, ВнешняяСистема);
		Если НЕ ЗначениеЗаполнено(КоллекцияНоменклатуры) ИЛИ НЕ ЗначениеЗаполнено(КоллекцияНоменклатуры.ВерсияДанных) Тогда
			КоллекцияНоменклатуры = Справочники.КоллекцииНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
		КонецЕсли;
	КонецЕсли;
	Возврат КоллекцияНоменклатуры;
	
КонецФункции 


#Область ВидыЦен

// ищет элемент при импорте - по узлу json-текста
Функция НайтиВидЦены(Узел, ВнешняяСистема) Экспорт

	Рез = Неопределено;
	ГУИД = "";
	Если узел.Свойство("Ref", ГУИД) Тогда
		Рез = НайтиВидЦеныПоГУИД(ГУИД, ВнешняяСистема);
	КонецЕсли;
	Возврат Рез;
	
КонецФункции

// ищет элемент по ГУИД в мэппинге, если там нет - в справочнике
Функция НайтиВидЦеныПоГУИД(ГУИД, ВнешняяСистема) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ГУИД) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Рез = РегистрыСведений.ксп_МэппингСправочникВидыЦен.ПоМэппингу(ГУИД, ВнешняяСистема);
	
	Если НЕ ЗначениеЗаполнено(Рез) ИЛИ НЕ ЗначениеЗаполнено(Рез.ВерсияДанных) Тогда
		Рез = Справочники.ВидыЦен.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	
	Возврат Рез;
	
КонецФункции

#КонецОбласти

//// Описание_метода
////
//// Параметры:
////	Параметр1 	- Тип1 - 
////
//// Возвращаемое значение:
////	Тип: Тип_значения
////
//Функция НайтиВалюту(УзелВалюты) Экспорт
//	
//	ВалютаКод = "";
//	Если УзелВалюты.Свойство("currencyCode", ВалютаКод) Тогда
//		Возврат Справочники.Валюты.НайтиПоКоду(ВалютаКод);
//	КонецЕсли;
//		
//	Возврат Неопределено;

//КонецФункции

//// Описание_метода
////
//// Параметры:
////	Параметр1 	- Тип1 - 
////
//// Возвращаемое значение:
////	Тип: Тип_значения
////
//Функция НайтиПроект(УзелПроект) Экспорт
//	
//	ПроектГУИД = "";
//	Если УзелПроект.Свойство("Ref", ПроектГУИД) Тогда
//		Возврат Справочники.Проекты.ПолучитьСсылку(Новый УникальныйИдентификатор(ПроектГУИД));
//	КонецЕсли;
//		
//	Возврат Неопределено;


//КонецФункции

//// Описание_метода
////
//// Параметры:
////	Параметр1 	- Тип1 - 
////
//// Возвращаемое значение:
////	Тип: Тип_значения
////
//Функция НайтиПодразделение(УзелПодразделение) Экспорт
//	
//	ПодразделениеГУИД = "";
//	Если УзелПодразделение.Свойство("Ref", ПодразделениеГУИД) Тогда
//		Возврат Справочники.Подразделения.ПолучитьСсылку(Новый УникальныйИдентификатор(ПодразделениеГУИД));
//	КонецЕсли;
//		
//	Возврат Неопределено;


//КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиБанковскийСчетОрганизации(НомерСчета, БИК) Экспорт
		
	Банк = НайтиБанк(БИК);
	Если НЕ ЗначениеЗаполнено(Банк) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	БанковскиеСчетаОрганизаций.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчета
		|ГДЕ
		|	БанковскиеСчета.НомерСчета = &НомерСчета
		|	И БанковскиеСчета.Банк = &Банк";
	
	Запрос.УстановитьПараметр("НомерСчета", НомерСчета);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиБанковскийСчетКонтрагента(НомерСчета, БИК) Экспорт
		
	Банк = НайтиБанк(БИК);
	Если НЕ ЗначениеЗаполнено(Банк) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	БанковскиеСчетаКонтрагентов.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.БанковскиеСчетаКонтрагентов КАК БанковскиеСчета
		|ГДЕ
		|	БанковскиеСчета.НомерСчета = &НомерСчета
		|	И БанковскиеСчета.Банк = &Банк";
	
	Запрос.УстановитьПараметр("НомерСчета", НомерСчета);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиБанковскийСчет(НомерСчета, БИК) Экспорт
		
	Банк = НайтиБанк(БИК);
	Если НЕ ЗначениеЗаполнено(Банк) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	БанковскиеСчета.Ссылка КАК Ссылка
		|ИЗ
//{{MRG[ <-> ]
		|	Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчета
//}}MRG[ <-> ]
//{{MRG[ <-> ]
//		|	Справочник.БанковскиеСчета КАК БанковскиеСчета
//}}MRG[ <-> ]
		|ГДЕ
		|	БанковскиеСчета.НомерСчета = &НомерСчета
		|	И БанковскиеСчета.Банк = &Банк";
	
	Запрос.УстановитьПараметр("НомерСчета", НомерСчета);
	Запрос.УстановитьПараметр("Банк", Банк);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиБанк(БИК) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КлассификаторБанков.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.КлассификаторБанков КАК КлассификаторБанков
		|ГДЕ
		|	КлассификаторБанков.Код = &Код";
	
	Запрос.УстановитьПараметр("Код", БИК);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиДисконтнуюКарту(Штрихкод, МагнитныйКод) Экспорт

	Если ЗначениеЗаполнено(МагнитныйКод) Тогда
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	ИнформационныеКарты.Ссылка КАК Ссылка
			|ИЗ
			|	Справочник.ИнформационныеКарты КАК ИнформационныеКарты
			|ГДЕ
			|	ИнформационныеКарты.КодКарты = &КодКарты";
		
		Запрос.УстановитьПараметр("КодКарты", МагнитныйКод);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Возврат ВыборкаДетальныеЗаписи.Ссылка;
		КонецЦикла;
	КонецЕсли;

	Если ЗначениеЗаполнено(Штрихкод) Тогда
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	Штрихкоды.Владелец КАК ИнфКарта
			|ИЗ
			|	РегистрСведений.Штрихкоды КАК Штрихкоды
			|ГДЕ
			|	Штрихкоды.Штрихкод = &Штрихкод";
		
		Запрос.УстановитьПараметр("Штрихкод", Штрихкод);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Возврат ВыборкаДетальныеЗаписи.ИнфКарта;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

Функция НайтиОрганизацию(Узел, ВнешняяСистема) Экспорт
	
	Организация = Неопределено;
	гуид = "";
	Если узел.Свойство("Ref", гуид) Тогда
		Организация = РегистрыСведений.ксп_МэппингСправочникОрганизации.ПоМэппингу(гуид, ВнешняяСистема);
		Если НЕ ЗначениеЗаполнено(Организация) ИЛИ НЕ ЗначениеЗаполнено(Организация.ВерсияДанных) Тогда
			Организация = Справочники.Организации.ПолучитьСсылку(Новый УникальныйИдентификатор(гуид));
		КонецЕсли;
	КонецЕсли;
		
	Возврат Организация;
	
КонецФункции

Функция НайтиСтатьиДДС(Узел, ВнешняяСистема) Экспорт
	
	СтатьиДДС = Неопределено;
	гуид = "";
	Если узел.Свойство("Ref", гуид) Тогда
		СтатьиДДС = РегистрыСведений.ксп_МэппингСправочникСтатьиДДС.ПоМэппингу(гуид, ВнешняяСистема);
		Если НЕ ЗначениеЗаполнено(СтатьиДДС) ИЛИ НЕ ЗначениеЗаполнено(СтатьиДДС.ВерсияДанных) Тогда
			СтатьиДДС = Справочники.СтатьиДвиженияДенежныхСредств.ПолучитьСсылку(Новый УникальныйИдентификатор(гуид));
		КонецЕсли;
	КонецЕсли;
		
	Возврат СтатьиДДС;
	
КонецФункции

// Возвращает пользователя для подстановки в документы
// Это может быть предопределенный элемеент
// или какой-то еще
//
// Параметры:
//	нет
//
// Возвращаемое значение:
//	Тип: СправочникСсылка.Пользователи
//
Функция ОтветственныйПоУмолчанию() Экспорт
	
	// заглушка. Вернем битую ссылку, ее пока достаточно
	Возврат Справочники.Пользователи.ПолучитьСсылку(Новый УникальныйИдентификатор);
	
КонецФункции

#Область Склад

// ищет склад при импорте - по узлу json-текста
Функция НайтиСклад(Узел, ВнешняяСистема) Экспорт

	Склад = Неопределено;
	ГУИД = "";
	Если узел.Свойство("Ref", ГУИД) Тогда
		Склад = НайтиСкладПоГУИД(ГУИД, ВнешняяСистема);
	КонецЕсли;
	Возврат Склад;
	
КонецФункции

// ищет склад по ГУИД в мэппинге, если там нет - в справочнике
Функция НайтиСкладПоГУИД(ГУИД, ВнешняяСистема) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ГУИД) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Склад = РегистрыСведений.ксп_МэппингСправочникСклады.ПоМэппингу(ГУИД, ВнешняяСистема);
	Если НЕ ЗначениеЗаполнено(Склад) ИЛИ НЕ ЗначениеЗаполнено(Склад.ВерсияДанных) Тогда
		Склад = Справочники.Склады.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	Возврат Склад;
	
КонецФункции

#КонецОбласти

#Область КлючиАналитикиУчетаНоменклатуры

// Использовать этот!!!!! Для заполнения колонки "АналитикаУчетаНоменклатуры" в ТЧ "Товары" (и других)
//
// Параметры:
//	Номенклатура 	- СправочникСсылка.Номенклатура - 
//	Склад		 	- СправочникСсылка.Склады - 
//	Характеристика	- СправочникСсылка.ХарактеристикиНоменклатуры - 
//
// Возвращаемое значение:
//	Тип: СправочникСсылка.КлючиАналитикиУчетаНоменклатуры
//
Функция НайтиСоздатьКлючАналитикиНом(Номенклатура, Склад, Характеристика) Экспорт
	
	Рез = НайтиКлючАналитикиНом(Номенклатура, Склад, Характеристика);
	
	Если НЕ ЗначениеЗаполнено(Рез) Тогда
		
		Возврат СоздатьКлючАналитикиНом(Номенклатура, Склад, Характеристика);
		
	КонецЕсли;
	
	Возврат Рез;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиКлючАналитикиНом(Номенклатура, Склад, Характеристика) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Спр.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.КлючиАналитикиУчетаНоменклатуры КАК Спр
	|ГДЕ
	|	Спр.Номенклатура = &Номенклатура
	|	И Спр.МестоХранения = &МестоХранения
	|	И Спр.Характеристика = &Характеристика
	|	И Спр.ТипМестаХранения = &ТипМестаХранения";
	
	Запрос.УстановитьПараметр("МестоХранения", Склад);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Запрос.УстановитьПараметр("ТипМестаХранения", Перечисления.ТипыМестХранения.Склад);
	Запрос.УстановитьПараметр("Характеристика", Характеристика);
	Запрос.УстановитьПараметр("СкладскаяТерритория", Склад);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьКлючАналитикиНом(Номенклатура, Склад, Характеристика) Экспорт
	
	Рез = Справочники.КлючиАналитикиУчетаНоменклатуры.СоздатьЭлемент();
	Рез.МестоХранения = Склад;
	РЕз.Номенклатура = Номенклатура;
	Рез.СкладскаяТерритория = Склад;
	Рез.Наименование = Строка(Номенклатура) + "; " + Строка(Склад);
	Рез.ТипМестаХранения = Перечисления.ТипыМестХранения.Склад;
	Рез.Характеристика = Характеристика;
	
	Рез.ДополнительныеСвойства.Вставить("НеРегистрироватьКОбменуRabbitMQ", Истина);
	
	Рез.Записать();
	Рез = Рез.Ссылка; // переопределим, чтобы не писать лишний код
	
	Возврат Рез;
	
КонецФункции

#КонецОбласти


Функция НайтиКонтрагента(Узел, ВнешняяСистема) Экспорт
	
	//Контрагент = Неопределено;
	//ГУИД = "";
	//Если узел.Свойство("Ref", ГУИД) Тогда
	//	Возврат Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	//КонецЕсли;
	//
	//Возврат Неопределено;
	
	Контрагент = Неопределено;
	ГУИД = "";
	Если узел.Свойство("Ref", ГУИД) Тогда
		Контрагент = РегистрыСведений.ксп_МэппингСправочникКонтрагенты.ПоМэппингу(ГУИД, ВнешняяСистема);
		Если НЕ ЗначениеЗаполнено(Контрагент) ИЛИ НЕ ЗначениеЗаполнено(Контрагент.ВерсияДанных) Тогда
			Контрагент = Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
		КонецЕсли;
	КонецЕсли;
	Возврат Контрагент;
	
КонецФункции

Функция НайтиГруппуФинансовогоУчета (Узел, ВнешняяСистема) Экспорт
		
	ГруппаФинансовогоУчета = Неопределено;
	ГУИД = "";
	Если узел.Свойство("Ref", ГУИД) Тогда
		ГруппаФинансовогоУчета = Справочники.ГруппыФинансовогоУчетаРасчетов.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

Функция НайтиДоговор(УзелДоговора, УзелКонтрагента = Неопределено, КонтрагентСсылка = Неопределено) Экспорт

	Рез = Неопределено;
	ГУИД = "";
	
	Если ТипЗнч(УзелДоговора)=Тип("Структура") И УзелДоговора.Свойство("Ref", ГУИД) Тогда
		Рез = Справочники.ДоговорыКонтрагентов.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	
	Возврат Рез;
		
КонецФункции

Функция НайтиНазначение(Узел, ВнешняяСистема) Экспорт

	Назначение = Неопределено;
	ГУИД = "";
	Если Узел.Свойство("Ref", ГУИД) Тогда
		Назначение = Справочники.Назначения.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	
	Возврат Назначение;
		
КонецФункции

Функция НайтиПодразделение(Узел, ВнешняяСистема) Экспорт

	Подразделение = Неопределено;
	ГУИД = "";
	Если Узел.Свойство("Ref", ГУИД) Тогда
		Подразделение = Справочники.СтруктураПредприятия.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	
	Возврат Подразделение;
		
КонецФункции

Функция НайтиСкидкуНаценку(Узел, ВнешняяСистема) Экспорт

	СкидкаНаценка = Неопределено;
	ГУИД = "";
	Если Узел.Свойство("Ref", ГУИД) Тогда
		СкидкаНаценка = Справочники.СкидкиНаценки.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	
	Возврат СкидкаНаценка;
		
КонецФункции

Функция НайтиБонуснуюПрограммуЛояльности(Узел, ВнешняяСистема) Экспорт

	БонуснаяПрограмма = Неопределено;
	ГУИД = "";
	Если Узел.Свойство("Ref", ГУИД) Тогда
		БонуснаяПрограмма = Справочники.БонусныеПрограммыЛояльности.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	
	Возврат БонуснаяПрограмма;
		
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиВидЗапасовСобственныйТовар(Организация) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВидыЗапасов.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ВидыЗапасов КАК ВидыЗапасов
		|ГДЕ
		|	ВидыЗапасов.Организация = &Организация
		|	И ВидыЗапасов.ТипЗапасов = &ТипЗапасов";
	
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ТипЗапасов", перечисления.ТипыЗапасов.Товар);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

Функция НайтиХарактеристику(УзелХарактеристики) Экспорт
	
	ХарактеристикаГУИД = "";
	Если УзелХарактеристики.Свойство("Ref", ХарактеристикаГУИД) Тогда
		Возврат Справочники.ХарактеристикиНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(ХарактеристикаГУИД));
	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции

Функция НайтиЕдиницуИзмерения(УзелЕдиницы, УзелНоменклатуры = Неопределено) Экспорт
	
	Наименование = "";
	УзелЕдиницы.Свойство("Наименование", Наименование);
	Если НЕ ЗначениеЗаполнено(Наименование) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Владелец = "";
	УзелЕдиницы.Свойство("Owner", Владелец);
	
	Если (НЕ ЗначениеЗаполнено(Владелец)) 
		ИЛИ
		(Владелец.type = "Справочник.НаборыУпаковок"
		И
		Владелец.Predefined = true
		И
		Владелец.PredefinedName = "БазовыеЕдиницыИзмерения")
		Тогда
		Возврат Справочники.БазовыеЕдиницыИзмерения.НайтиПоНаименованию(УзелЕдиницы.Наименование, Истина);
	КонецЕсли;
		
	Если ЗначениеЗаполнено(Владелец) И Владелец.type = "Справочник.Номенклатура" Тогда
		
		Если ЗначениеЗаполнено(УзелНоменклатуры) Тогда
			Запрос = Новый Запрос;
			Запрос.Текст = 
				"ВЫБРАТЬ
				|	УпаковкиНоменклатуры.Ссылка КАК Ссылка
				|ИЗ
				|	Справочник.УпаковкиНоменклатуры КАК УпаковкиНоменклатуры
				|ГДЕ
				|	УпаковкиНоменклатуры.Наименование = &Наименование
				|	И УпаковкиНоменклатуры.Владелец = &Владелец";
			
			//через имя общ модуля, чтобы ПИ работало
			Владелец = ксп_ИмпортСлужебный.НайтиНоменклатуру(УзелНоменклатуры);
			
			Запрос.УстановитьПараметр("Владелец", Владелец);
			
			РезультатЗапроса = Запрос.Выполнить();
			
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				Возврат ВыборкаДетальныеЗаписи.Ссылка;
			КонецЦикла;
		КонецЕсли;	
		
	КонецЕсли;
	
		
	Возврат Неопределено;
	
КонецФункции

Функция НайтиАналитикуУчетаНоменклатуры(Узел) Экспорт
	
	АналитикаУчетаНоменклатурыГУИД = "";
	Если Узел.Свойство("Ref", АналитикаУчетаНоменклатурыГУИД) Тогда
		Возврат Справочники.КлючиАналитикиУчетаНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(АналитикаУчетаНоменклатурыГУИД));
	КонецЕсли;
		
	Возврат Неопределено;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиСоздатьОбъектРасчетовСКлиентом(ДокументРасчетовОбъект, Организация) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ОбъектыРасчетов.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ОбъектыРасчетов КАК ОбъектыРасчетов
	|ГДЕ
	|	ОбъектыРасчетов.Объект = &ДокументРасчетовСсылка
	|	И ОбъектыРасчетов.ТипРасчетов = &ТипРасчетов
	|	И ОбъектыРасчетов.Организация = &Организация";
	
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ДокументРасчетовСсылка", ДокументРасчетовОбъект.Ссылка);
	Запрос.УстановитьПараметр("ТипРасчетов", Перечисления.ТипыРасчетовСПартнерами.РасчетыСКлиентом);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Рез = Неопределено;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Рез = ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Рез) Тогда
		
		РезОбк = Справочники.ОбъектыРасчетов.СоздатьЭлемент();
		РезОбк.Организация = Организация;
		РезОбк.Объект = ДокументРасчетовОбъект.Ссылка;
		РезОбк.ТипРасчетов = Перечисления.ТипыРасчетовСПартнерами.РасчетыСКлиентом;
		РезОбк.ТипОбъектаРасчетов = Перечисления.ТипыОбъектовРасчетов.ПлатежВозврат;
		РезОбк.состояние = 0;
		
		Если ДокументРасчетовОбъект.Проведен Тогда
			РезОбк.состояние = 1;
		КонецЕсли;
		Если ДокументРасчетовОбъект.ПометкаУдаления Тогда
			РезОбк.состояние = 2;
		КонецЕсли;
		
		РезОбк.Записать();
		
		Рез = РезОбк.Ссылка;
		
	КонецЕсли;
	
	Возврат Рез;
	
КонецФункции



// Заглушка для общих действий после импорта документа
//
// Параметры:
//	ОбъектДанных	- ДокументОбъект - объект документа после метода Записать()
//	мВнешняяСистема	- строка - имя внешней системы, из которой пришел документ 
//	СтруктураОбъекта 	- структура - json-строка прочитанная в структуру
//	jsonText	- строка - исходный текст сообщения
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ОбъектПлагина) Экспорт
	
	// ЕНС. Это должно вызываться из ПроверитьКачествоДанных()
	//ДобавитьОтложенноеПроведение(ОбъектДанных.Ссылка);
	
	Возврат Неопределено;
	
	//_Ссылка = ОбъектДанных.Ссылка;
	//
	//Попытка
	//	
	//	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	//	деф = СтруктураОбъекта.definition;
	//	Если деф.isPosted Тогда 
	//		ОбъектДанных.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
	//	КонецЕсли;
	//	
	//Исключение
	//    ЗаписьЖурналаРегистрации("ИмпортИзRabbit", УровеньЖурналаРегистрации.Ошибка,,_Ссылка,"Не удалось провести документ при импорте!");
	//КонецПопытки;
	//
	//Возврат Неопределено;
	
КонецФункции

// Заглушка для общих действий после импорта документа
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ОбъектПлагина) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

// Заглушка для общих действий после импорта документа
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ОбъектПлагина) Экспорт
	
	ПроверитьКачествоДанных(ОбъектДанных, ОбъектПлагина);
	
	Возврат Неопределено;
	
КонецФункции

// Заглушка для общих действий после импорта документа
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ОбъектПлагина) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

// Заглушка для общих действий после импорта документа
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ОбъектПлагина) Экспорт
	
	Возврат Неопределено;
	
КонецФункции



// Добавляет записи в регистры сведений:
// ксп_ОтложенноеПроведение
// ксп_ОтложенноеПроведениеПроблемы
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ДобавитьПроблемуОтложенногоПроведения(ДанныеСсылка, ИмяРеквизита, ИмяТаблЧасти=Неопределено, НомерСтрокиТЧ=0, ВидПроблемы) Экспорт
	
		
	Если ВидПроблемы = Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения Тогда
	ИначеЕсли ВидПроблемы = Перечисления.ксп_ВидыПроблемКачестваДокументов.БитаяСсылка Тогда
		
	КонецЕсли; 
	
	НЗ = РегистрыСведений.ксп_ОтложенноеПроведениеПроблемы.СоздатьНаборЗаписей();
	НЗ.Отбор.ДокументСсылка.Установить(ДанныеСсылка);
	НЗ.Отбор.ИмяРеквизита.Установить(ИмяРеквизита);
	НЗ.Отбор.ИмяТаблЧасти.Установить(ИмяТаблЧасти);
	НЗ.Отбор.НомерСтрокиТЧ.Установить(НомерСтрокиТЧ);
	
	НЗ.Прочитать();
	Если НЗ.Количество() > 0 Тогда
		
		стрк = НЗ[0];
		
	Иначе 
		
		стрк = НЗ.Добавить();
		стрк.ДокументСсылка = ДанныеСсылка;
		стрк.ИмяРеквизита = ИмяРеквизита;
		стрк.ИмяТаблЧасти = ИмяТаблЧасти;
		стрк.НомерСтрокиТЧ = НомерСтрокиТЧ;
		
	КонецЕсли;
	
	стрк.ОписаниеПроблемы = "";
	стрк.ВидПроблемы = ВидПроблемы;
	
	НЗ.Записать();
		
КонецПроцедуры

// Добавляем документ к отложенному проведению. Статус передаем через параметр
Процедура ДобавитьОтложенноеПроведение(ДанныеСсылка, СтатусОбъекта = Неопределено) Экспорт
	
	НЗ = РегистрыСведений.ксп_ОтложенноеПроведение.СоздатьНаборЗаписей();
	НЗ.Отбор.ДокументСсылка.Установить(ДанныеСсылка);
	
	НЗ.Прочитать();
	Если НЗ.Количество() > 0 Тогда
		
		стрк = НЗ[0];
		
	Иначе 
		
		стрк = НЗ.Добавить();
		стрк.ДокументСсылка = ДанныеСсылка;
			
	КонецЕсли; 
	
	Если СтатусОбъекта = Неопределено Тогда
		стрк.СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.ОК;
	Иначе 
		стрк.СтатусОбъекта = СтатусОбъекта;
	КонецЕсли;
	
	стрк.СтатусПроведения = Перечисления.КСП_СтатусыОтложенногоПроведения.НеПроведен;
	
	НЗ.Записать();
			
КонецПроцедуры

// Описание_метода
//
// Параметры:
//	ДокументОбъект 	- Объект документ - объект в данном случае удобнее, т.к. он есть в контексте места вызова
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПроверитьКачествоДанных(ДокументОбъект, ОбъектОбработкиИмпорта) Экспорт
	
	СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.ОК;
	
	РегистрыСведений.ксп_ОтложенноеПроведениеПроблемы.ОчиститьПоДокументу(ДокументОбъект.Ссылка);
	
	// проверить шапку
	
	МассивРеквизитовШапкиДляПроверки = ОбъектОбработкиИмпорта.МассивРеквизитовШапкиДляПроверки();
	
	ОбнаруженыПустыеРеквизиты = Ложь;
	Для каждого РеквизитИмя Из МассивРеквизитовШапкиДляПроверки Цикл
		
		РеквизитЗначение = ДокументОбъект[РеквизитИмя];
		
		// Да, здесь дублирование кода и можно переписать компактнее. Но так - нагляднее
		
		Если ТипЗнч(РеквизитЗначение) = Тип("Булево") или ТипЗнч(РеквизитЗначение) = Тип("Строка") или ТипЗнч(РеквизитЗначение) = Тип("Число")
			или ТипЗнч(РеквизитЗначение) = Тип("Дата") или ТипЗнч(РеквизитЗначение) = Тип("Неопределено") Тогда
	
			Если НЕ ЗначениеЗаполнено(РеквизитЗначение) Тогда 
				
				ДобавитьПроблемуОтложенногоПроведения(
					ДокументОбъект.Ссылка, РеквизитИмя, Неопределено, 0, 
					Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения);
					
				СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.Ошибка;
					
				ОбнаруженыПустыеРеквизиты = Истина;
			КонецЕсли;	
			
		Иначе	// ссылочный тип	
			
			Если НЕ ЗначениеЗаполнено(РеквизитЗначение) Тогда 
				
				ДобавитьПроблемуОтложенногоПроведения(
					ДокументОбъект.Ссылка, РеквизитИмя, Неопределено, 0, 
					Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения);
					
				СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.Ошибка;
				
				ОбнаруженыПустыеРеквизиты = Истина;
//{{MRG[ <-> ]
//			Иначе 
//				
//}}MRG[ <-> ]
				
//{{MRG[ <-> ]
			ИначеЕсли ЗначениеЗаполнено(РеквизитЗначение) 
				И НЕ ЗначениеЗаполнено(РеквизитЗначение.ВерсияДанных) Тогда
//				Если Перечисления.ТипВсеСсылки().СодержитТип(ТипЗнч(РеквизитЗначение)) Тогда
//					//ничего не делаем
//				ИначеЕсли НЕ ЗначениеЗаполнено(РеквизитЗначение.ВерсияДанных) Тогда
				ДобавитьПроблемуОтложенногоПроведения(
					ДокументОбъект.Ссылка, РеквизитИмя, Неопределено, 0, 
					Перечисления.ксп_ВидыПроблемКачестваДокументов.БитаяСсылка);
				СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.Ожидание;	
				ОбнаруженыПустыеРеквизиты = Истина;
				
			КонецЕсли;
			
		КонецЕсли;	
		
	КонецЦикла;
	
	// А здесь дублирование кода, чтобы быстрее работало - не стал выносить в отдельный метод,
	// чтобы интерпретатор не тратил время на его вызов
	
	// ЕНС. Этого метода в обработке может не быть, поэтому через попытку
	//ТЗ, Колонки:
	// * ИмяТЧ
	// * ИмяКолонки       
	Попытка
		ТабличныеЧастиДляПроверки = ОбъектОбработкиИмпорта.ТабличныеЧастиДляПроверки();
	Исключение
	    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
	КонецПопытки;
	
	Если ТипЗнч(ТабличныеЧастиДляПроверки) = тип("ТаблицаЗначений") Тогда
		Для каждого стрк Из ТабличныеЧастиДляПроверки Цикл   // перебор имен колонок ТЧ
			
			счСтрок = 1;
			Для каждого стркТЧ Из ДокументОбъект[стрк.ИмяТЧ] Цикл
				
				РеквизитЗначение = стркТЧ[стрк.ИмяКолонки];
				
				РеквизитИмя = стрк.ИмяКолонки;
				
			
				Если ТипЗнч(РеквизитЗначение) = Тип("Булево") или ТипЗнч(РеквизитЗначение) = Тип("Строка") или ТипЗнч(РеквизитЗначение) = Тип("Число")
					или ТипЗнч(РеквизитЗначение) = Тип("Дата") или ТипЗнч(РеквизитЗначение) = Тип("Неопределено") Тогда
			
					Если НЕ ЗначениеЗаполнено(РеквизитЗначение) Тогда 
						
						ДобавитьПроблемуОтложенногоПроведения(
							ДокументОбъект.Ссылка, РеквизитИмя, стрк.ИмяТЧ, счСтрок, 
							Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения);
							
						СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.Ошибка;
						
						ОбнаруженыПустыеРеквизиты = Истина;
					КонецЕсли;	
					
				Иначе	// ссылочный тип	
					
					Если НЕ ЗначениеЗаполнено(РеквизитЗначение) Тогда 
						
						ДобавитьПроблемуОтложенногоПроведения(
							ДокументОбъект.Ссылка, РеквизитИмя, стрк.ИмяТЧ, счСтрок, 
							Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения);
							
						СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.Ошибка;
						
						ОбнаруженыПустыеРеквизиты = Истина;
					ИначеЕсли ЗначениеЗаполнено(РеквизитЗначение) 
						И НЕ ЗначениеЗаполнено(РеквизитЗначение.ВерсияДанных) Тогда

						ДобавитьПроблемуОтложенногоПроведения(
							ДокументОбъект.Ссылка, РеквизитИмя, стрк.ИмяТЧ, счСтрок, 
							Перечисления.ксп_ВидыПроблемКачестваДокументов.БитаяСсылка);
							
						СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.Ожидание;
						
						ОбнаруженыПустыеРеквизиты = Истина;
					КонецЕсли;
					
				КонецЕсли;	
				
				счСтрок = счСтрок + 1;
			КонецЦикла;
			
		КонецЦикла;
	КонецЕсли;
	
	// в конце - финальная проверка на наличие проблем
	Если НЕ ОбнаруженыПустыеРеквизиты Тогда
		СтатусОбъекта = Перечисления.ксп_СтатусыКачестваДокументов.ОК;
		
	Иначе
		// статус уже определен ранее
		
	КонецЕсли;
//{{MRG[ <-> ]
//
//	Попытка
//		// в обработке может не быть метода ТребуетсяПроведение() (пока он в процессе добавления)
//		Если ОбъектОбработкиИмпорта.ТребуетсяПроведение() Тогда
//			ДобавитьОтложенноеПроведение(ДокументОбъект.Ссылка, СтатусОбъекта);
//		КонецЕсли;
//	Исключение
//	    
//	КонецПопытки;
//}}MRG[ <-> ]
	
	ДобавитьОтложенноеПроведение(ДокументОбъект.Ссылка, СтатусОбъекта);
		
	Возврат Неопределено;
	
КонецФункции


Функция ОпределитьСтавкуНДСПоСправочникуЕРП(УзелСправочника) Экспорт
	
	Если НЕ УзелСправочника.Свойство("ПеречислениеСтавкаНДС") Тогда
		Возврат Неопределено;
	КонецЕсли; 
	
	Если НЕ УзелСправочника.ПеречислениеСтавкаНДС.Свойство("Значение") Тогда
		Возврат Неопределено;
	КонецЕсли; 
	
	СтавкаНДС = УзелСправочника.ПеречислениеСтавкаНДС.Значение;//строка
	Рез = Неопределено;
	Если СтавкаНДС = "НДС18" Тогда
		Рез = Перечисления.СтавкиНДС.НДС18;
	ИначеЕсли СтавкаНДС = "НДС18_118" Тогда
		Рез = Перечисления.СтавкиНДС.НДС18_118;
	ИначеЕсли СтавкаНДС = "НДС10" Тогда
		Рез = Перечисления.СтавкиНДС.НДС10;
	ИначеЕсли СтавкаНДС = "НДС10_110" Тогда
		Рез = Перечисления.СтавкиНДС.НДС10_110;
	ИначеЕсли СтавкаНДС = "НДС0" Тогда
		Рез = Перечисления.СтавкиНДС.НДС0;
	ИначеЕсли СтавкаНДС = "БезНДС" Тогда
		Рез = Перечисления.СтавкиНДС.БезНДС;
	ИначеЕсли СтавкаНДС = "НДС20" Тогда
		Рез = Перечисления.СтавкиНДС.НДС20;
	ИначеЕсли СтавкаНДС = "НДС20_120" Тогда
		Рез = Перечисления.СтавкиНДС.НДС20_120;
	ИначеЕсли СтавкаНДС = "НДС12" Тогда
		Рез = Перечисления.СтавкиНДС.НДС12;
	КонецЕсли;
	
	Запрос = Новый Запрос("Выбрать Ссылка ИЗ Справочник.СтавкиНДС ГДЕ ПеречислениеСтавкаНДС = &ПеречислениеСтавкаНДС");
	Запрос.УстановитьПараметр("ПеречислениеСтавкаНДС", Рез);
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.Ссылка;
	
КонецФункции

Функция НайтиЗначениеПеречисления(ВидПеречисления, ЗначениеСтрокой) Экспорт

	//ааа = Метаданные.Перечисления[ВидПеречисления];
	
	//Для каждого зн из ааа.ЗначенияПеречисления Цикл
		
	//	Если зн.Имя = ЗначениеСтрокой Тогда
			//Возврат зн;  
	//	КонецЕсли; 
	
	//КонецЦикла; 
	
	Возврат Перечисления[ВидПеречисления][ЗначениеСтрокой];;
	
КонецФункции
 
// Описание_метода
//
// Параметры:
//	Код 	- строка - "RUB" / "USD" ...
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиВалютуИзУзла(Узел) Экспорт
	
	Если Узел.Свойство("currencyCode") Тогда
	
		Код = Узел.currencyCode;
	Иначе
		
		Возврат Неопределено;
	
	КонецЕсли; 
	
	Возврат Справочники.Валюты.НайтиПоКоду(Код);
	
КонецФункции

#Область Касса

// ищет кассу при импорте - по узлу json-текста
Функция НайтиКассу(Узел, ВнешняяСистема) Экспорт

	рез = Неопределено;
	ГУИД = "";
	Если узел.Свойство("Ref", ГУИД) Тогда
		рез = НайтиКассуПоГУИД(ГУИД, ВнешняяСистема);
	КонецЕсли;
	Возврат рез;
	
КонецФункции

// ищет кассу по ГУИД в мэппинге, если там нет - в справочнике
Функция НайтиКассуПоГУИД(ГУИД, ВнешняяСистема) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ГУИД) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	рез = РегистрыСведений.ксп_МэппингСправочникКассы.ПоМэппингу(ГУИД, ВнешняяСистема);
	Если НЕ ЗначениеЗаполнено(рез) ИЛИ НЕ ЗначениеЗаполнено(рез.ВерсияДанных) Тогда
		рез = Справочники.Кассы.ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	КонецЕсли;
	Возврат рез;
	
КонецФункции

#КонецОбласти

// https://wiki.elis.ru/pages/viewpage.action?pageId=362100
Функция ДействиеСДокументом(ЭтоНовый, СуществующийДокСсылка, деф) Экспорт
	
	НЕ_ЗАГРУЖАТЬ = 1;
	СОЗДАТЬ = 2;
	ОБНОВИТЬ = 3;
	ОТМЕНИТЬ_ПРОВЕДЕНИЕ = 4;
	ПОМЕТИТЬ = 5;
	
	Если НЕ ЭтоНовый Тогда	
		
		Если СуществующийДокСсылка.ПометкаУдаления Тогда
			
			Если деф.DeletionMark = Истина Тогда
				Возврат НЕ_ЗАГРУЖАТЬ;
			ИначеЕсли НЕ деф.isPosted Тогда
				Возврат НЕ_ЗАГРУЖАТЬ;
			ИначеЕсли деф.isPosted Тогда
				Возврат ОБНОВИТЬ;
			КонецЕсли;		
			
		ИначеЕсли НЕ СуществующийДокСсылка.Проведен Тогда
			
			Если деф.DeletionMark = Истина Тогда
				//Возврат НЕ_ЗАГРУЖАТЬ;  
                Возврат ПОМЕТИТЬ; // изменено 2024-07-03
			ИначеЕсли НЕ деф.isPosted Тогда
				Возврат НЕ_ЗАГРУЖАТЬ;
			ИначеЕсли деф.isPosted Тогда
				Возврат ОБНОВИТЬ;
			КонецЕсли;
			
		ИначеЕсли СуществующийДокСсылка.Проведен Тогда
			
			Если деф.DeletionMark = Истина Тогда
				//Возврат ОТМЕНИТЬ_ПРОВЕДЕНИЕ;
                Возврат ПОМЕТИТЬ; // изменено 2024-07-03 				
			ИначеЕсли НЕ деф.isPosted Тогда
				Возврат ОТМЕНИТЬ_ПРОВЕДЕНИЕ;
			ИначеЕсли деф.isPosted Тогда
				Возврат ОБНОВИТЬ;
			КонецЕсли;

		КонецЕсли;
		
	Иначе // новый документ
		
		Если деф.DeletionMark = Истина Тогда
			Возврат НЕ_ЗАГРУЖАТЬ;
		ИначеЕсли НЕ деф.isPosted Тогда
			Возврат НЕ_ЗАГРУЖАТЬ;
		ИначеЕсли деф.isPosted Тогда
			Возврат СОЗДАТЬ;
		КонецЕсли;		

	КонецЕсли;
		
	Возврат НЕ_ЗАГРУЖАТЬ;
	
КонецФункции

