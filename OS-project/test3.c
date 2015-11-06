#include<stdio.h>
#include<sema.h>
#include<errno.h>

void testInit(void);

int main(int argc,char *argv[]){
testInit();
return(0);
}

void testInit(){
	int breth=0;
	int okk,i;




	for(i=0;i<=31;i++){
		sem_destroy(i);
	}

	for(i=0;i<=31;i++){
		sem_init(2);
	}	
	okk=sem_init(2);
	if (errno==12){
		printf("init MEM test passed");
	}
	else{
		printf("init MEM test failed");
	}
	for(i=0;i<=31;i++){
		sem_destroy(i);
	}
	
	okk=sem_init(-4);
	if (errno==22){
		printf("init VAL test passed");
	}
	else{
		printf("init VAL test failed");
	}
}