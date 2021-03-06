﻿Перем юТест;

////////////////////////////////////////////////////////////////////
// Программный интерфейс

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	юТест = ЮнитТестирование;
	
	ВсеТесты = Новый Массив;

	ВсеТесты.Добавить("ТестДолжен_СоздатьЭкземплярСоединения");
	ВсеТесты.Добавить("ТестДолжен_ОтправитьСтрокуПривет");
	ВсеТесты.Добавить("ТестДолжен_ПолучитьСтрокуПривет");

	Возврат ВсеТесты;
	
КонецФункции

Процедура ТестДолжен_СоздатьЭкземплярСоединения() Экспорт

	Либа = Новый СоединениеRMQ;
	юТест.ПроверитьРавенство(ТипЗнч(Либа), Тип("СоединениеRMQ"), "Не создался экзепляр");

	ЛибаEng = Новый ConnectionRMQ;
	юТест.ПроверитьРавенство(ТипЗнч(ЛибаEng), Тип("ConnectionRMQ"), "Не создался экзепляр ENG");

КонецПроцедуры

Процедура ТестДолжен_ОтправитьСтрокуПривет() Экспорт

	Соединение = Новый СоединениеRMQ;
	
	Соединение.Пользователь = "guest";
	Соединение.Пароль = "guest";
	Соединение.Сервер = "localhost";
	Соединение.ВиртуальныйХост = "/";
	
	Клиент = Соединение.Установить();
	Клиент.ОтправитьСтроку("Привет", "test");
	
	Соединение.Закрыть();

КонецПроцедуры


Процедура ТестДолжен_ПолучитьСтрокуПривет() Экспорт

	Соединение = Новый СоединениеRMQ;
	
	Соединение.Пользователь = "guest";
	Соединение.Пароль = "guest";
	Соединение.Сервер = "localhost";
	Соединение.ВиртуальныйХост = "/";
	
	Клиент = Соединение.Установить();
	СообщениеИзОчереди = Клиент.ПолучитьСтроку("test");
	
	Соединение.Закрыть();

    юТест.ПроверитьРавенство(СообщениеИзОчереди, "Привет");

КонецПроцедуры

Процедура ТестДолжен_ПолучитьПустуюСтроку() Экспорт

	Соединение = Новый СоединениеRMQ;
	
	Соединение.Пользователь = "guest";
	Соединение.Пароль = "guest";
	Соединение.Сервер = "localhost";
	Соединение.ВиртуальныйХост = "/";
	
	Клиент = Соединение.Установить();
	Клиент.ОтправитьСтроку("", "test");
	
	СообщениеИзОчереди = Клиент.ПолучитьСтроку("test");
	юТест.ПроверитьРавенство(СообщениеИзОчереди, "");
    
    СообщенияНет = Клиент.ПолучитьСтроку("test");
    юТест.ПроверитьРавенство(СообщенияНет, "");

	Соединение.Закрыть();
КонецПроцедуры
