%option case-insensitive
%option noyywrap 
%option yylineno

%x str
%x teleia

%{

#include <stdio.h>
#include <string.h>
#include <ctype.h>



#define ID		1
#define ICONST		2
#define RCONST		3
#define BCONST		4
#define CCONST		5
#define STRING		6

 /* reserver symbols */
#define PROGRAM		7
#define CONST		8
#define TYPE		9
#define ARRAY		10
#define SET		11
#define OF		12
#define RECORD		13
#define VAR		14
#define FORWARD		15
#define FUNCTION	16
#define PROCEDURE	17
#define INTEGER		18
#define REAL		19
#define BOOLEAN		20
#define CHAR		21
#define BEGIN2		22
#define END		23
#define IF		24
#define THEN		25
#define ELSE		26
#define CASE		27
#define OTHERWISE	28
#define WHILE		29
#define DO		30
#define FOR		31
#define TO		32
#define DOWNTO		33
#define WITH		34
#define READ		35
#define WRITE		36

 /* operators */
#define RELOP		37
#define ADDOP		38
#define OROP		39
#define MULDIVANDOP	40
#define NOTOP		41
#define INOP		42
#define LPAREN		43
#define RPAREN		44
#define SEMI		45
#define DOT		46
#define COMMA		47
#define EQU		48
#define COLON		49
#define LBRACK		50
#define RBRACK		51
#define ASSIGN		52
#define DOTDOT		53

void ERROR(const char *msg);
int checkSymbol(char *current);
int insertSymbol(char *current);


typedef struct{
	int intval;
	int intval2;
	char *strval;
	}YYSTYPE;
	
YYSTYPE yylval;
char *msg="Brethike lathos";
int sfalma=0;
int flag=0;
char array;
char *c,*b;
char linebuf[500];


struct SymbolTable {
  int index;
  char *content;
  struct SymbolTable *next;
};


%}




D            	  [ \t\n\r]
space                 {D}+
letter            [a-zA-Z]
digit             [0-9]
char              [a-zA-Z0-9~`!@#$%^&*()_+={[}]\|:;'<,>.?\t]
comment           \{({char}|\"|\r|\n)*\}



%%




"PROGRAM"				{printf("PROGRAM keyword\n"); return PROGRAM;}
"CONST"					{printf("CONST keyword\n"); return CONST;}
"TYPE"					{printf("TYPE keyword\n"); return TYPE;}
"ARRAY"					{printf("ARRAY keyword\n"); return ARRAY;}
"SET"					{printf("SET keyword\n"); return SET;}
"OF"					{printf("OF keyword\n"); return OF;}
"RECORD"				{printf("RECORD keyword\n"); return RECORD;}
"VAR"					{printf("VAR keyword\n"); return VAR;}
"FORWARD"				{printf("FORWARD keyword\n"); return FORWARD;}
"FUNCTION"				{printf("FUNCTION keyword\n"); return FUNCTION;}
"PROCEDURE"				{printf("PROCEDURE keyword\n"); return PROCEDURE;}
"INTEGER"				{printf("INTEGER keyword\n");return INTEGER;}
"REAL"					{printf("REAL keyword\n"); return REAL;}
"BOOLEAN"				{printf("BOOLEAN keyword\n"); return BOOLEAN;}
"CHAR"					{printf("CHAR keyword\n"); return CHAR;}
"BEGIN"					{printf("BEGIN keyword\n"); return BEGIN2;}
"END"					{printf("END keyword\n"); return END;}
"IF"					{printf("IF keyword\n"); return IF;}
"THEN"					{printf("THEN keyword\n"); return THEN;}
"ELSE"					{printf("ELSE keyword\n"); return ELSE;}
"CASE"					{printf("CASE keyword\n"); return CASE;}
"OTHERWISE"				{printf("OTHERWISE keyword\n"); return OTHERWISE;}
"WHILE"					{printf("WHILE keyword\n"); return WHILE;}
"DO"					{printf("DO keyword\n"); return  DO;}
"FOR"					{printf("FOR keyword\n"); return  FOR;}
"TO"					{printf("TO keyword\n"); return  TO;}
"DOWNTO"				{printf("DOWNTO keyword\n"); return DOWNTO;}
"WITH"					{printf("WITH keyword\n"); return WITH;}
"READ"					{printf("READ keyword\n"); return READ;}
"WRITE"					{printf("WRITE keyword\n"); return WRITE;}

"TRUE" 	    				{printf("BCONST: %s\n",yytext);yylval.intval=1;return BCONST;}
"FALSE"					{printf("BCONST: %s\n",yytext);yylval.intval=0;return BCONST;}

">"|">="|"<"|"<="|"<>"			{printf("RELOP: %s\n",yytext);return RELOP;}
"+"|"-"								{printf("ADDOP: %s\n",yytext);return ADDOP;}
"OR"								{printf("OROP: %s\n",yytext);return OROP;}
"*"|"/"|"DIV"|"MOD"|"AND"			{printf("MULDIVANDOP: %s\n",yytext);return MULDIVANDOP;}
"NOT"								{printf("NOTOP: %s\n",yytext);return NOTOP;}
"IN"								{printf("IN: %s\n",yytext);return INOP;}


[_]?{letter}+[a-zA-Z0-9_]*[a-zA-Z0-9]+|{letter}+[a-zA-Z0-9]*		{printf("ID: %s\n",yytext); return ID;}

[+-]?{digit}"."				{printf("DOT: %s\n",yytext);BEGIN(teleia);return DOT;}

<teleia>\.	{printf("dotdot found\n");BEGIN(0);return DOTDOT;}
<teleia>.	{array=(char) yytext;unput(array);BEGIN(0);}


[+-]?{digit}             								{printf("Decimal ICONST: %s \n", yytext);yylval.intval=atoi(yytext);return ICONST;}
"0."0*[1-9]*                    							{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0""."{digit}*[1-9]+{digit}*        							{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*"."0									{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*"."{digit}*[1-9]+{digit}*						{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*"."[1-9]*          							{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"."[1-9]*[Ee][+-][1-9]+{digit}*                   					{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"."[1-9]+                       							{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"."{digit}*[1-9]+[0-9]*           							{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0""."[1-9]*[Ee][+-][1-9]+{digit}*                    					{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0""."[1-9]*[Ee][1-9]+{digit}*                   					{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0""."{digit}*[1-9]+{digit}*[Ee][+-][1-9]+{digit}*        				{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0""."{digit}*[1-9]+{digit}*[Ee][1-9]+{digit}*       					{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*"."[1-9]*[Ee][+-][1-9]+{digit}*          				{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*"."{digit}*[1-9]+[0-9]*[Ee][+-][1-9]+{digit}*				{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*"."[1-9]*[Ee][1-9]+{digit}*          					{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*"."{digit}*[1-9]+{digit}*[Ee][1-9]+{digit}*				{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*[Ee][+-][1-9]+{digit}*							{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
[1-9]+{digit}*[Ee][1-9]+{digit}*							{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"."[1-9]*[Ee][1-9]+{digit}*                       					{printf("decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"."{digit}*[1-9]+{digit}*[Ee][+-][1-9]+{digit}*       					{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"."{digit}*[1-9]+{digit}*[Ee][1-9]+{digit}*           					{printf("Decimal RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0X""."[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*                     			{printf("hex RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0X""."[1-9A-Fa-f]*                                        		 		{printf("hex RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0X""0""."[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*                  	 		{printf("hex RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0X""0""."[1-9A-Fa-f]*                                     		 		{printf("hex RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0X"[1-9A-F]+[0-9A-Fa-f]*"."[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*   			{printf("hex RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}
"0X"[1-9A-Fa-f]+[0-9A-Fa-f]*"."[1-9A-Fa-f]*                      	 		{printf("hex RCONST : %s \n", yytext);yylval.intval=atof(yytext);return RCONST;}


[1-9]+{digit}*   		        			{printf("Decimal ICONST: %s \n", yytext);yylval.intval=atoi(yytext);return ICONST;}
"0X"[1-9A-F]+[0-9A-F]*	       					{printf("Hex ICONST:  %s \n",  yytext);yylval.intval=atof(yytext);return ICONST;}
"0"[1]+[0-1]*                  				{printf("Binary ICONST:  %s \n", yytext);yylval.intval=atof(yytext);return ICONST;}



"'"[!-~]"'"        		{printf("Cconst : %s\n",yytext);yylval.strval=strdup(yytext);return CCONST;}
\'\\n\'	   			{printf("Cconst: Line feed\n");yylval.strval=yytext;return CCONST;}
\'\\f\'	   			{printf("Cconst: Form feed\n");yylval.strval=yytext;return CCONST;}
\'\\t\'	   			{printf("Cconst: Horizontal Tab\n");yylval.strval=yytext;return CCONST;}
\'\\r\'	   			{printf("Cconst: Carriage return\n");yylval.strval=yytext;return CCONST;}
\'\\b\'	   			{printf("Cconst: Back Space\n");yylval.strval=yytext;return CCONST;}
\'\\v\'	   			{printf("Cconst: Vertical Tab\n");yylval.strval=yytext;return CCONST;}




"("				{printf("LPAREN: %s\n",yytext);return LPAREN;}
")"				{printf("RPAREN: %s\n",yytext);return RPAREN;}
";"				{printf("SEMI: %s\n",yytext);return SEMI;}
"."				{printf("DOT: %s\n",yytext);BEGIN(teleia);return DOT;}
","				{printf("COMMA: %s\n",yytext);return COMMA;}
"="				{printf("EQU: %s\n",yytext);return EQU;}
":"       			{printf("COLON: %s\n",yytext);return COLON;}
"["				{printf("LBRACK: %s\n",yytext);return LBRACK;}
"]"				{printf("RBRACK: %s\n",yytext);return RBRACK;}
":="				{printf("ASSIGN: %s\n",yytext);return ASSIGN;}


\"              	{
			  printf("String found : ");
			  BEGIN(str);
			}
{comment} 		{printf("Comment found: %s\n",yytext);}

\n.*  { strncpy(linebuf, yytext+1, sizeof(linebuf)); 
            yyless(1);     
          }
          
{space}				{}

.				{
					if(sfalma==0){
					printf("Panic mode\n");
						sfalma=1;
					
					}
					else{
						ERROR(msg);
					}
				}

<<EOF>>                          {printf("EOF\n"); return 0;}



<str>\\n\"			 {yytext=c;
			  printf("End of string: %s\n",yytext);  
			  BEGIN(0);
			  return STRING;}
			  
<str>[a-zA-Z0-9~`!@#$%^&*()_+=|:;'<,>.? ]* {
					      printf("\nPart of string: %s\n",yytext);
					      if(flag==1){
						c=(char *)malloc(strlen(yytext)+strlen(b));
						if(c!=NULL){
						  strcpy(c,b);
						  strcat(c,yytext);
						 }
					      }
						else{
						  b=(char *)malloc(strlen(yytext)+1);
						  strcpy(b,yytext);
						}
					}
<str>\\           		 {
				printf("Slash found : ");
				array=input();
				flag=1;
				while (array == ' ' || array == '\n' ){
				array=input();
				
				};
				unput(array);
				BEGIN(str);
			}



%%

struct SymbolTable *table_head = NULL;
int table_size = 1;

int checkSymbol(char *current) {
  struct SymbolTable *curr_entry = table_head;
  while(curr_entry) {
    if(strcmp(curr_entry->content, current) == 0) {
      return curr_entry->index;
    }
    curr_entry = curr_entry->next;
  }
  return -1;
}


int insertSymbol(char *current) {
  int result = checkSymbol(current);
  if(result == -1) { 
    struct SymbolTable *new_entry = (struct SymbolTable *)malloc(sizeof(struct SymbolTable));
	table_size++;
    new_entry->index = table_size; 
    int size = strlen(current);
    new_entry->content = (char *)malloc((size+1)*sizeof(char));
    memcpy(new_entry->content, current, size+1);
    new_entry->next = table_head;
    table_head = new_entry;
    
    return new_entry->index;
  }
  else 
    return result;
}



int main(){
int token;

token=yylex();

while(token!=0){
	if(token==1){
		token=insertSymbol(yytext);
		/*epistrefei ti thesi sto pinaka symvolwn*/
		yylval.intval=token;
		printf("Symbol ID id :%d in Symbol Table\n",token);
	}
	token=yylex();

	}
return 0;

}

void ERROR(const char *msg){
	fprintf(stderr,"ERROR,at %d: %s\n",yylineno,msg);
	printf("%d: %s at %s in this line:\n%s\n",yylineno,msg, yytext, linebuf);
	exit(1);
	}




