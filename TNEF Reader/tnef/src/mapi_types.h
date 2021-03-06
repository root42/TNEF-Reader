/* This file generated by names.awk do not edit! */
#ifndef MAPI_TYPES_H
#define MAPI_TYPES_H
enum _mapi_type {
	szMAPI_UNSPECIFIED                            = 0x0000,
	szMAPI_NULL                                   = 0x0001,
	szMAPI_SHORT                                  = 0x0002,
	szMAPI_INT                                    = 0x0003,
	szMAPI_FLOAT                                  = 0x0004,
	szMAPI_DOUBLE                                 = 0x0005,
	szMAPI_CURRENCY                               = 0x0006,
	szMAPI_APPTIME                                = 0x0007,
	szMAPI_ERROR                                  = 0x000a,
	szMAPI_BOOLEAN                                = 0x000b,
	szMAPI_OBJECT                                 = 0x000d,
	szMAPI_INT8BYTE                               = 0x0014,
	szMAPI_STRING                                 = 0x001e,
	szMAPI_UNICODE_STRING                         = 0x001f,
	szMAPI_SYSTIME                                = 0x0040,
	szMAPI_CLSID                                  = 0x0048,
	szMAPI_BINARY                                 = 0x0102,
};
typedef enum _mapi_type mapi_type;
extern char*
get_mapi_type_str(uint16 d);
#endif /* MAPI_TYPES_H */
