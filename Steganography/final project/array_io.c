#include "array_io.h"


void array_io (dout_t d_o[N], din_t d_i[N], din_t m_i[M]) {

	// *** EDIT *** //
	// int i,j,k, rem,image_lsb,message_bit;
	// unused variable 'rem'
	int i,j,l, image_lsb,message_bit;
	// *** EDIT *** //


	// *** RSA *** //
	int pt;
	long long int k;

	For_Loop: for (i=0;i<N;i++) {
			d_o[i] = d_i[i];
		}


	d_o[149]=M;
	l=150;

	for (i = 0; i < M; i++) {
		pt = m_i[i];
		pt = pt - 96;
		k = 1;
		// for (j = PUB_KEY; j > 0; j--) {
		for (j = 0; j < PUB_KEY; j++) {
			k = k * pt;
			k = k % PQ;	// PQ is defined in header file
		}
		m_i[i] = k;


		for (j=1;j<=64;j++){

			image_lsb=d_i[l] & 1;

			// *** EDIT *** //
			// message_bit=(m_i[i]>>8-j) & 1;
			message_bit=(k>>(64-j)) & 1;
			// *** EDIT *** //
			
			if(image_lsb == message_bit){
				d_o[l]=d_i[l];
			}
			else{
				if(image_lsb == 0){
					d_o[l]=d_i[l] | 1;
				}
				else{
					d_o[l]=d_i[l] & ~1;
				}

			}
			l++;
		}
	}
  

}

void array_io_decode (dout_t d_o[M], din_t d_i[N]){


	long long int k,ct;
	int pt;
	int i,j,n;

	for(i=0;i<M;i++) {
				long long int temp_ch=0;
				for(j = 0;j < 64 ;j++) {
					temp_ch=temp_ch<<1;
					long long int file_byte_lsb = d_i[j+i*64+150] & 1;

					//k++;
					temp_ch|=file_byte_lsb;

				}
	

	// *** RSA *** //

		ct = temp_ch;
		k = 1;
		// for (j = PRV_KEY; j > 0; j--) {
		for (n = 0; n < PRV_KEY; n++) {
			k = k * ct;
			k = k % PQ;	// PQ is defined in header file
		}
		pt = k + 96;
		d_o[i] = pt;
	}
	// *** RSA *** //


}









