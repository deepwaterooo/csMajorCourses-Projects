#include "mystrings.h"

// this file includes some routines for portability.

// split a string up into parts using characters from the delimeter set 
// delimSet as separaters.   The result is a list of pointers to the parts.
// empty parts are removed.  The function returns the number of parts found.
// NOTE: The routine destroys the string argument given by inserting EOS's
// and then returning pointers to the parts of the string.  You can't deallocate
// the string as long as there are pointers to the parts.
//
// this is similar but not the same as strsep available on some unixes.
int split(char *s, char *delimSet, char **list) 
{
    int len;
    bool set;

    len = 0;
    set = true;
    for (char *p=s; *p; p++) {
        if (strchr(delimSet, *p)) {
            *p = '\0';
            set = true;
        }
        else if (set) {
            list[len++] = p;
            set = false;
        }
    }

    return len;
}

// take a string in readable format including control marks and
// return the actual character.  For instance '^C' becomes a control-C.
// NOTE: Control characters should be uppercase.
// NOTE: space is allocated.
char *niceStringIn(char *s)
{
    int len;
    char *t;

    len = strlen(s);
    t = new char [len+1];

    unsigned char *tp = (unsigned char *)t;
    unsigned char *sp = (unsigned char *)s;
    for (; sp<(unsigned char *)s+len; sp++) {
        if (*sp=='\\') {
            sp++;
            if (*sp=='t') {
                *tp++ = '\t';
            }
            else if (*sp=='n') {
                *tp++ = '\n';
            }
            else if (*sp=='0') {
                *tp++ = '\0';
            }
            else {
                *tp++ = *sp;
            }
        }
        else if (*sp=='^') {
            sp++;
            *tp++ = (*sp) ^ 0x40;
        }
        else {
            *tp++ = *sp;
        }
    }
    *tp='\0';

    return t;
}

// creates a string in a nice form even for 
// normally unprintable characters like control-C.
// NOTE: space is allocated.
char *niceStringOut(char *s) 
{
    int len;
    char *t;

    len = strlen(s);
    t = new char [3*len+1];

    unsigned char *tp = (unsigned char *)t;
    unsigned char *sp = (unsigned char *)s;
    for (; sp<(unsigned char *)s+len; sp++) {

        if (*sp=='\t') {
            *tp++ = '\\';
            *tp++ = 't';
           }
        else if (*sp=='\n') {
           *tp++ = '\\';
            *tp++ = 'n';
        }
        else if (*sp=='\0') {
           *tp++ = '\\';
            *tp++ = '0';
        }
        else if (*sp<' ') {
            *tp++ = '^';
            *tp++ = *sp;
        }
        else if (*sp==127) {
            *tp++ = '^';
            *tp++ = '?';
        }
        else if (*sp>127) {
            *tp++ = '\\';
           *tp++ = "0123456789abcdef"[(*sp)/16];
           *tp++ = "0123456789abcdef"[(*sp)%16];
           }
        else {
           *tp++ = *sp;
           }
    }
    *tp='\0';

    return t;
}

