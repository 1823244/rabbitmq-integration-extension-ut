﻿
Функция ПоМэппингу (Соответствие, ТипСоответствия, ВнешняяСистема) Экспорт
	
	Запрос = Новый запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ксп_МэппингСправочникВидыНоменклатуры.ВидНоменклатуры КАК ВидНоменклатуры
	|ИЗ
	|	РегистрСведений.ксп_МэппингСправочникВидыНоменклатуры КАК ксп_МэппингСправочникВидыНоменклатуры
	|ГДЕ
	|	ксп_МэппингСправочникВидыНоменклатуры.Соответствие = &Соответствие
	|	ксп_МэппингСправочникВидыНоменклатуры.ТипСоответствия = &ТипСоответствия
	|	ксп_МэппингСправочникВидыНоменклатуры.ВнешняяСистема = &ВнешняяСистема";
	
	Запрос.УстановитьПараметр("Соответствие", Соответствие);
	Запрос.УстановитьПараметр("ТипСоответствия", ТипСоответствия);
	Запрос.УстановитьПараметр("ВнешняяСистема", ВнешняяСистема);
	
	Результат = Запрос.Выполнить(); 
	
	Выборка = Результат.Выбрать(); 
	
	Пока Выборка.Следующий() Цикл
		
		Возврат Выборка.ВидНоменклатуры;
		
	КонецЦикла;
	
	Возврат Справочники.ВидыНоменклатуры.ПустаяСсылка();
	
КонецФункции