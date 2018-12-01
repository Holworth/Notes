#include "string.h"

int strlen(char *src)
{
	int i;
	for (i = 0; src[i] != '\0'; i++)
	{
	}
	return i;
}

void memcpy(uint8_t *dest, uint8_t *src, uint32_t len)
{
	for (; len != 0; len--)
	{
		*dest++ = *src++;
	}
}

void mmemcpy(char *dest, char *src, int len)
{
	for (; len != 0; len--)
	{
		*dest++ = *src++;
	}
}

void memset(void *dest, uint8_t val, uint32_t len)
{
	uint8_t *dst = (uint8_t *)dest;

	for (; len != 0; len--)
	{
		*dst++ = val;
	}
}

void bzero(void *dest, uint32_t len)
{
	memset(dest, 0, len);
}

int strcmp(char *str1, char *str2)
{
	while (*str1 && *str2 && (*str1 == *str2))
	{
		str1++;
		str2++;
	};

	if (*str1 == '\0' && *str2 == '\0')
	{
		return 0;
	}

	if (*str1 == '\0')
	{
		return -1;
	}

	return 1;
}

char *strcpy(char *dest, char *src)
{
	char *tmp = dest;

	while (*src)
	{
		*dest++ = *src++;
	}

	*dest = '\0';

	return tmp;
}

int atoi(char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}

inline int is_hex_char(char c)
{
	return ('0' <= c && c <= '9') || ('a' <= c && c <= 'f' );
}

int htoi(char *s)
{
  int n;

  n = 0;
  while(is_hex_char(*s))
  {
	if(('0' <= *s && *s <= '9') )
	{
		n = n*16 + *s++ - '0';
	}else//('a' <= c && c <= 'f' )
	{
		n = n*16 + *s++ - 'a' + 10;		
	}
  }
  return n;
}