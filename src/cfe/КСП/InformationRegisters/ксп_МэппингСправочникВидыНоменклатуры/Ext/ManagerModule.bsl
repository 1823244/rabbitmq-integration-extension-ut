﻿Функция ПоМэппингу (ТипСоответствия, Соответствие, ВнешняяСистема, ВидВоспроизводства) Экспорт

 Запрос = Новый запрос;
 Запрос.Текст = 
 "ВЫБРАТЬ
 |	ксп_МэппингСправочникВидыНоменклатуры.ВидНоменклатуры КАК ВидНоменклатуры
 |ИЗ
 |	РегистрСведений.ксп_МэппингСправочникВидыНоменклатуры КАК ксп_МэппингСправочникВидыНоменклатуры
 |ГДЕ
 |	ксп_МэппингСправочникВидыНоменклатуры.СоответствиеИзЕРП = &СоответствиеИзЕРП";
 
 Запрос.УстановитьПараметр("СоответствиеИзЕРП", ТипСоответствия);
 
 Результат = Запрос.Выполнить(); 
 
 Выборка = Результат.Выбрать(); 
 
 Пока Выборка.Следующий() Цикл
	 
	 Возврат Выборка.ВидНоменклатуры;
	 
 КонецЦикла; 
 
 Возврат Справочники.ВидыНоменклатуры.ПустаяСсылка();
 
КонецФункции