#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define PORT 12345
int sock, socket2, lg;
char mess[80];
struct sockaddr_in local;   			// champs pour adresse de la machine
struct sockaddr_in distant; 			// champs pour adresses distantes (clients)

void creer_socket()
{ // preparation des champs d entete
   bzero(&local, sizeof(local));		// Mise à zéro du champs adresse
   local.sin_family = AF_INET;		// adresse type IP
   local.sin_port = htons(PORT);		// Numéro de port
   local.sin_addr.s_addr = INADDR_ANY;	// adresse IP du poste par défaut
   bzero(&(local.sin_zero),8);

   lg = sizeof(struct sockaddr_in);
 // Creation de la socket en mode TCP/IP
   if((sock=socket(AF_INET, SOCK_STREAM,0)) == -1){perror("socket"); exit(1);}
 // Nommage de la socket avec le n° de port 12345
   if(bind(sock, (struct sockaddr *)&local, sizeof(struct sockaddr)) == -1)    {perror("bind");exit(1);}
}

void main()
{ creer_socket();	// Création de la socket en mode TCP/IP

   listen(sock,5)	;	// mise à l écoute
   while(1)		// Boucle de traitement d'un client
     {  	printf ("En  attente d un client\n");
	socket2=accept(sock, (struct sockaddr *)&distant, &lg);
	printf ("client connecte \n");
             if (fork()==0)
	{	strcpy(mess,"");
		while (strncmp(mess,"fin",3)!=0)
		{ read(socket2,mess,80);
	 	 printf ("le client me dit %s \n",mess);
             	write(socket2, "message recu !",80);
		}
       		close(socket2);       			// fermeture socket d'échange
  		exit(1);
             }
    }
}
