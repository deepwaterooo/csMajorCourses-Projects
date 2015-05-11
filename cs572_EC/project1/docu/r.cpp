#include <stdio.h>
#include <elf.h>
#include <link.h>

int main()
{
    const ElfW(Dyn) *dyn = _DYNAMIC;
    const ElfW(Dyn) *rpath = NULL;
    const char *strtab = NULL;
    for (; dyn->d_tag != DT_NULL; ++dyn) {
        if (dyn->d_tag == DT_RPATH) {
            rpath = dyn;
        } else if (dyn->d_tag == DT_STRTAB) {
            strtab = (const char *)dyn->d_un.d_val;
        }
    }

    if (strtab != NULL && rpath != NULL) {
        printf("RPATH: %s\n", strtab + rpath->d_un.d_val);
    }
    return 0;
}
