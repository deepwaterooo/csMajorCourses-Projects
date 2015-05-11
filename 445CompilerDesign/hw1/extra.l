[\{\}\(\),:;+-\*/%\<\>=]{return yytext[0];}

main() {
	// lex through the input:
	yylex();
}



