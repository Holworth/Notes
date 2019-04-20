/* NUS - CS3211 AY2015/2016 Sem 2
 *
 * This program shows overflow when adding integers
 *
 */
#include <stdio.h>
#include <gmp.h>
#include <stdlib.h>

// mpz_t a;
// mpz_init(a);
// mpz_set_ui(a,0);
// mpz_add_ui(a,a,1);

int main(int argc, char **argv)
{

	int i, j, k;
	long long count = 0;
	mpz_t a;
	mpz_init(a);
	mpz_set_ui(a, 0);

	printf("Adding 1 to 0, lots of times...\n");

	for (i = 1; i < 3000; i++)
	{
		for (k = 1; k <= 1000000000; k++)
		{
			mpz_add_ui(a, a, 1);
			// a = a + 1;
			count = count + 1;
		}
		gmp_printf("Adding %ld 1s to 0 gives this result: %Zd\n", count, a);
	}

	return 0;
}
