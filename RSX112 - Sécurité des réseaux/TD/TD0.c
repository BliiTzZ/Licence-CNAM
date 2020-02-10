#include <stdio.h>
#include <netdb.h>
#include <fcntl.h>
#include <string.h>			// chaines de caracteres
#include <sys/socket.h> 		// interface socket
#include <netinet/in.h> 			// gestion adresses ip
#include <sys/types.h>
#include <unistd.h>

#define SERV "127.0.0.1"  		// adresse IP = boucle locale
#define PORT 12345	  		// port decoute serveur
int port,sock;		  		// n°port et socket
char mess[80];		  		// chaine de caracteres

struct  sockaddr_in     serv_addr;	// zone adresse
struct  hostent         *server;		// nom serveur

creer_socket()
{  port = PORT;
  server = gethostbyname(SERV);		// verification existance adresse
  if (!server){fprintf(stderr, "Problème serveur \"%s\"\n", SERV);exit(1);}
  // creation socket locale
  sock = socket(AF_INET, SOCK_STREAM, 0); // AF_INET=famille adresse internet
					  // SOCK_STREAM= mode connecte-TCP
  bzero(&serv_addr, sizeof(serv_addr));	  // preparation champs entete
  serv_addr.sin_family = AF_INET;	  // Type dadresses
  bcopy(server->h_addr, &serv_addr.sin_addr.s_addr,server->h_length);
  serv_addr.sin_port = htons(port);	  // port de connexion du serveur
}

main()
{ creer_socket();			// creation socket

if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
   {perror("Connexion impossible:");exit(1);} // connexion au serveur
  printf ("connexion avec serveur ok\n");

	strcpy(mess1,"");
	while (strncmp(mess1,"fin",3)!=0)
	{  printf ("Votre message : ");
               gets(mess1);
               write(sock,mess1,80);
               read(sock,mess2,80);
               printf ("Le serveur me dit :%s\n ",mess2);
	}

  close (sock);		// fermeture connexion
}

2 - Programme serveur

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

main()
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
  		exit 1 ;
             }
     }
