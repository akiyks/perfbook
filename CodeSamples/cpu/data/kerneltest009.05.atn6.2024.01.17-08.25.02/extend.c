#include <stdio.h>

int main(void)
{
  long timestamp;
  unsigned int count;
  int i;
  int ret;

  do {
    ret = scanf("%ld %u", &timestamp, &count);
    if (ret != 2) break;

    for (i = 0; i < count; i++)
      printf("%ld\n", timestamp);
  } while (ret == 2);
  return 0;    
}
