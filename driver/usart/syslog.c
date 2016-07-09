#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdbool.h>
#include <stdarg.h>
#include <stdint.h>

int __wrap_printf( const char * format, ... )
{
     va_list ap;
     int ret;

     va_start(ap, format);
     ret = vprintf(format, ap);
     va_end(ap);

	 return ret;
}	
