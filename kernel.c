//kernel.c

void kmain(void) {
    const char *str = "Hello world!";
    char *vidptr = (char*)0xb8000; //video mem begin
    unsigned int i = 0;
    unsigned int j = 0;

    //Loop to clear screen
    //25 lines, 80 cols, 2 bytes each
    while(j < 80 * 25 * 2) {
        vidptr[j] = ' ';
        //attribute byte - light grey on black
        vidptr[j+1] = 0x07;
        j = j + 2;
    }

    j = 0;

    //Loop to write string
    while(str[j] != '\0') {
        vidptr[i] = str[j];
        //attr byte - light grey on black
        vidptr[i+1] = 0x07;
        ++j;
        i = i + 2;
    }

    return;
}