#include <stdio.h>
#include <stdlib.h>
// un tableau qui contient les instructions binaires a executer
// la suite des instructions sont rangees dans la variable globale code.
// pour compiler : gcc prog.c -z execstack
char code[] = "\xeb\x3f\x5f\x80\x77\x0b\x41\x48\x31"
  "\xc0\x04\x02\x48\x31\xf6\x0f\x05\x66\x81"
  "\xec\xff\x0f\x48\x8d\x34\x24\x48\x89\xc7"
  "\x48\x31\xd2\x66\xba\xff\x0f\x48\x31\xc0"
  "\x0f\x05\x48\x31\xff\x40\x80\xc7\x01\x48"
  "\x89\xc2\x48\x31\xc0\x04\x01\x0f\x05\x48"
  "\x31\xc0\x04\x3c\x0f\x05\xe8\xbc\xff\xff"
  "\xff\x2f\x65\x74\x63\x2f\x70\x61\x73\x73"
  "\x77\x64\x41";

/*
 *
 */
int main(int argc, char** argv)
{
  printf("Debut du programme \n");
  int r;
do
{
  printf("Que souhaitez vous : 1 - execution normale / 2 : execution bizarre\n : ");
  scanf("%d",&r);
} while (r!=1 && r!=2);

if (r==1)
printf("execution normale, c'est fini \n");
else
  {int (*func)(); // Declaration d'un pointeur de fonction
  func = (int (*)()) code; // nous donnons directement le code binaire de la fonction func !
  func(); //appel de la fonction pointe par func
  exit(0);
}
}
