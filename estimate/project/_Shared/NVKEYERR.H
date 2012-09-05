/*
 * (C) 1997-2002 Aktiv Co. All rights reserved.
 * Definitions for use Guardant Stealth.
 *         Error codes.
 */

#ifndef __NVSKERR__H_
#define __NVSKERR__H_

const char *nv_pszErrors[nse_LastError+1] =

#ifdef  RUS
/*- Error codes ( Russian ) ------------------------------------------------*/
{
 "Нет ошибок",                                                        /* 00 */
 "Ключ не найден",                                                    /* 01 */
 "Ключ есть, но не с тем кодом",                                      /* 02 */
 "Указан слишком большой адрес",                                      /* 03 */
 "Счетчик байт в блоковой опеpации слишком велик",                    /* 04 */
 "GP достиг 0",                                                       /* 05 */
 "Невеpная команда",                                                  /* 06 */
 "Тайм-аут пpи записи",                                               /* 07 */
 "Ошибка верификации",                                                /* 08 */
 "Сетевой пpотокол не найден",                                        /* 09 */
 "Сетевой pесуpс пpогpаммы исчеpпан",                                 /* 10 */
 "Соединение с ключ-сеpвеpом потеpяно",                               /* 11 */
 "Нет ни одного ключ-сеpвеpа",                                        /* 12 */
 "Ключ-сеpвеpу не хватило памяти",                                    /* 13 */
 "Возникла ошибка DPMI-сеpвеpа",                                      /* 14 */
 "Внутpенняя ошибка",                                                 /* 15 */
 "Ключ-сеpвеp был пеpезагpужен",                                      /* 16 */
 "Команда не поддеpживается с этим ключом",                           /* 17 */
 "NT дpайвеp не найден",                                              /* 18 */
 "Ошибка сетевого протокола",                                         /* 19 */
 "Получен пакет недопустимого формата",                               /* 20 */
 "Вначале необходимо выполнить Login",                                /* 21 */
 "Вначале необходимо выполнить Logout",                               /* 22 */
 "Этот ключ сейчас занят",                                            /* 23 */
 "Драйвер не может занять LPT порт",                                  /* 24 */
 "",                                                                  /* 25 */
 "",                                                                  /* 26 */
 "",                                                                  /* 27 */
 "",                                                                  /* 28 */
 "",                                                                  /* 29 */
 "Ошибка CRC",                                                        /* 30 */
 "Ошибка CRC при чтении",                                             /* 31 */
 "Ошибка CRC при записи",                                             /* 32 */
 "Попытка выйти за границы памяти",                                   /* 33 */
 "Не найдено алгоpитма с запрошенным номером",                        /* 34 */
 "Ошибка CRC при выполнении алгоpитма",                               /* 35 */
 "Ошибка CRC при выполнении ChkNSK или нет больше ключей",            /* 36 */
 "Клиент NSK устаpел для данного ключа",                              /* 37 */
 "Задан ошибочный тип взаимно-обpатного пpеобpазования"               /* 38 */
};

#else           /* RUS  */

/*- Error codes ( English ) ------------------------------------------------*/
{
 "No errors",                                                         /* 00 */
 "Dongle with specified search conditions not found",                 /* 01 */
 "Code not found",                                                    /* 02 */
 "The specified address is too big",                                  /* 03 */
 "Byte counter too big",                                              /* 04 */
 "GP executions counter exhausted (has 0 value)",                     /* 05 */
 "Bad dongle call command",                                           /* 06 */
 "Write time out error",                                              /* 07 */
 "Write verification error",                                          /* 08 */
 "Network protocol not found",                                        /* 09 */
 "License counter of Guardant Net exhausted",                         /* 10 */
 "Connection with Guardant Net server was lost",                      /* 11 */
 "Guardant Net server not found",                                     /* 12 */
 "Guardant Net server memory allocation error",                       /* 13 */
 "Guardant Net server found DPMI error",                              /* 14 */
 "Guardant Net server internal error",                                /* 15 */
 "Guardant Net server has been reloaded",                             /* 16 */
 "This command is not supported by this dongle version (the version is too old)",/* 17 */
 "Windows NT driver is required",                                     /* 18 */
 "Network protocol error",                                            /* 19 */
 "Network packet format is not supported",                            /* 20 */
 "Logging in Guardant Net server is required",                        /* 21 */
 "Logging out from Guardant Net server is required",                  /* 22 */
 "Guardant Net is busy (locked by another copy of protected application)",/* 23 */
 "Guardant driver cannot capture the parallel port",                  /* 24 */
 "",                                                                  /* 25 */
 "",                                                                  /* 26 */
 "",                                                                  /* 27 */
 "",                                                                  /* 28 */
 "",                                                                  /* 29 */
 "CRC error occurred while attempting to call the dongle",	      /* 30 */
 "CRC error occurred while attempting to read data from the dongle",  /* 31 */
 "CRC error occurred while attempting to write data to the dongle",   /* 32 */
 "The boundary of the dongle's memory has been override",             /* 33 */
 "The hardware algorithm with this number has not been found in the dongle",/* 34 */
 "CRC error of the hardware algorithm",                               /* 35 */
 "CRC error occurred while attempting to execute ChkNSK operation, or all dongles found",/* 36 */
 "Guardant API release is too old",                                   /* 37 */
 "Non-existent reversible conversion method has been specified"       /* 38 */
};

#endif  /* RUS  */

/*--------------------------------------------------------------------------*/

#endif  /* __NVSKERR__H_        */
