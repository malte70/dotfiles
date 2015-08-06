#include <stdio.h>
#include <string.h>

void version() {
	printf("Foobar 0.1\n");
}

void help(char *prgname) {
	printf("Usage: %s [your name]\n", prgname);
}

int main(int argc, char *argv[]) {
	char message[200];
	
	//memset(message, '\0', sizeof(message));
	
	if (argc == 1) {
		strcpy(message, "Hello world!\n");
	} else if (argc == 2) {
		if (strcmp(argv[1], "--version") == 0) {
			version();
			return 0;
		} else if (strcmp(argv[1], "--help") == 0) {
			help(argv[0]);
			return 0;
		} else {
			strcpy(message, "Hello, ");
			strcat(message, argv[1]);
			strcat(message, "!\n");
		}
	} else {
		help(argv[0]);
		return 1;
	}
		
	printf("%s", message);
	
	return 0;
}
