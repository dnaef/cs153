
#include "types.h"
#include "stat.h"
#include "user.h"
// galust
int
main(int argc, char **argv)
{
	pid = fork();
	if (pid >0) {
		int status;
		wait(&status);
		//parent
		printf("%d", *status);
	}
	else if(pid==0){
		exit(0);//child execute
	}
	else{
	//error
}
return 0;
}
