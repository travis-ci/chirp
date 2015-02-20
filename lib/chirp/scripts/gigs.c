// vim:noexpandtab:ts=4:sts=4:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <string.h>

#define ONEMEG 1048576

void _gigs_log(char * message) {
	time_t rawtime;
	struct tm *timeinfo;
	char timebuf[256];

	time(&rawtime);
	timeinfo = localtime(&rawtime);
	strftime(timebuf, 256, "%Y-%m-%dT%H:%M:%S%z", timeinfo);

	printf("time=\"%s\" pid=%d msg=\"%s\"\n", timebuf, getpid(), message);
}

int main(int argc, char *argv[]) {
	double amt;
	double n = 1.0;
	unsigned long i;
	char msgbuf[32];
	char *membuf;

	if (argc > 1) {
		n = atof((const char *)argv[1]);
	}

	sprintf(msgbuf, "allocating %.2fGB", n);
	_gigs_log(msgbuf);

	if (NULL == (membuf = malloc((int)(sizeof(char) * (ONEMEG * 1024 * n))))) {
		int err = errno;
		_gigs_log("malloc failed");
		return 1;
	}

	_gigs_log("filling buffer");
	for (i = 0; i < (ONEMEG * 1024 * n); i++) {
		membuf[i] = 'z';
	}

	_gigs_log("exiting");
	return 0;
}
