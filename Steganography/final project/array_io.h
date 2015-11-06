#ifndef ARRAY_IO_H_
#define ARRAY_IO_H_
 
#include <stdio.h>

typedef char din_t;
typedef char dout_t;
typedef int dacc_t;

#define N 781400
#define M 27


void array_io (din_t d_o[N], din_t d_i[N], din_t m_i[M]);
void array_io_decode (dout_t d_o[M], din_t d_i[N]);


// *** RSA *** //
// #define PUB_KEY 3			// public key
#define PUB_KEY 13

// #define PRV_KEY 67827339		// private key
#define PRV_KEY 37

// #define PQ      101761183	// prime product (10007 * 10169)
#define PQ      77
// *** RSA *** //


#endif
