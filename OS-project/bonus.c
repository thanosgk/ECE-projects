#include <stdio.h>
#include <sema.h>


int main(){
	int i,s,j;
	FILE *fp;
	fp = fopen("bonuslines","w+");
	s=sem_init(1);
	fork();
	
	sem_down(s);
	for(i=1;i<=4;i++){
		
		for(j=1;j<=i;j++){
			
			fprintf(fp,"Line %d / %d by\n",j,i);			
			fflush(fp);
			sem_up(s);
			
		}
		
		
	}
	fclose(fp);
	return(0);
}