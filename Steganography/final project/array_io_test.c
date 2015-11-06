#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "array_io.h"


 
int main () {

	clock_t begin, end;
	double time_spent;


	din_t d_i[N];
	din_t m_i[M];
  	dout_t d_o[N];
  	dout_t d_o2[M];
	int i, retval=0;
	FILE *fp,*fp2;
	FILE *file_handle;
	FILE *message_handle;


	file_handle=fopen("lala.bmp","r");
	fp=fopen("result.bmp","w");
	fp2=fopen("result.txt","w");
	message_handle=fopen("message.txt","r");

	for(i=0;i<N;i++) {
		d_i[i]=fgetc(file_handle);
	}

	for(i=0;i<M;i++) {
		m_i[i]=fgetc(message_handle);
	}




	printf("\n*** Encryption ***\n");
	begin = clock ();
	// Call the function to operate on the data
	array_io(d_o,d_i,m_i);

	end = clock ();
	time_spent = (double) (end - begin) / CLOCKS_PER_SEC;
	printf("\rTime\t: %f\n", time_spent);
	// Save the results to a file
	for (i=0;i<N;i++) {
		fputc(d_o[i],fp);
	}




	printf("\n*** Decryption ***\n");
	begin = clock ();

	array_io_decode (d_o2,d_o);

	end = clock ();
	time_spent = (double) (end - begin) / CLOCKS_PER_SEC;
	printf("\rTime\t: %f\n", time_spent);
	// Save the results to a file
	for (i=0;i<M;i++) {
		fputc(d_o2[i],fp2);
	}




	fclose(fp);
	fclose(fp2);



	
	printf("\n*** Comparison ***\n");
	printf("Result\t: ");
	if (system("diff -w message.txt result.txt")) {
		printf("FAIL.\n\n");
		return 1;
	} else {
		printf("PASS!\n\n");
		return 0;
	}




	// Return 0 if the test passes
	return retval;
}
