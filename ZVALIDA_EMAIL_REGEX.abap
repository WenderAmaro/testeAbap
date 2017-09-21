REPORT zvalida_email_regex.

DATA: o_regex   TYPE REF TO cl_abap_regex,    " Objeto que cria uma combina��o usando Express�es Regulares
      o_matcher TYPE REF TO cl_abap_matcher.  " Objeto que resolve determinada combina��o

PARAMETERS: p_email TYPE c LENGTH 254. " Campo para Email

START-OF-SELECTION.

*--# Instacia o objeto O_REGEX
  CREATE OBJECT o_regex
    EXPORTING
      pattern     = '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' " Express�o Regular para valida��o de email
      ignore_case = abap_true.                                   " Flag para ignorar mai�sculas e min�sculas

*--# Ap�s instanciar o objecto O_REGEX com a Express�o Regular que queremos usar,
*--# instanciamos o objeto O_MATCHER com a Express�o e o dado a ser validado
  o_matcher = o_regex->create_matcher( text = p_email ).

*--# Executa o m�todo que resolve a Express�o Regular e checamos seu resultado
  IF o_matcher->match( ) EQ 'X'.  " Retorno 'X', a informa��o � v�lida
    WRITE: 'Email: ', p_email, ' � v�lido'.
  ELSE. " Retorno diferente de 'X', a informa��o � inv�lida
    WRITE: 'Email: ', p_email, ' � inv�lido'.
  ENDIF.