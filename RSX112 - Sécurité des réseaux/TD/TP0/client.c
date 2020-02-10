#include <stdio.h>
#include <stdlib.h>
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
char mess1[80];             // chaine de caracteres
char mess2[80];		  		// chaine de caracteres

struct  sockaddr_in     serv_addr;	// zone adresse
struct  hostent         *server;		// nom serveur

void creer_socket()
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

void main()
{ creer_socket();			// creation socket

if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
   {perror("Connexion impossible:");exit(1);} // connexion au serveur
  printf ("connexion avec serveur ok\n");

	strcpy(mess1,"");
	while (strncmp(mess1,"fin",3)!=0)
	{  printf ("Votre message : ");
               fgets(mess1, 50, stdin);
               write(sock,mess1,80);
               read(sock,mess2,80);
               printf ("Le serveur me dit :%s\n ",mess2);
	}

  close (sock);		// fermeture connexion
}
