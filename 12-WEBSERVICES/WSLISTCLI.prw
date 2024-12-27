#include 'totvs.ch'
#include 'topconn.ch'
#include 'APWEBSRV.CH'

WSSTRUCT StClientes

	WSDATA clienteA1CODIGO AS STRING OPTIONAL
	WSDATA clienteA1NOME   AS STRING OPTIONAL
	WSDATA clienteA1ENDE   AS STRING OPTIONAL
	WSDATA clienteA1CEP    AS STRING OPTIONAL
	WSDATA clienteA1BAIRRO AS STRING OPTIONAL
	WSDATA clienteA1MUN    AS STRING OPTIONAL
	WSDATA clienteA1EST    AS STRING OPTIONAL
ENDWSSTRUCT



//ESTRUTURA DE DADO NO FORMATO ARRAY
WSSTRUCT STlistClientes

	//array com base na estutura ScClientes
	WSDATA aRegsClientes    AS ARRAY OF StClientes OPTIONAL

	//strings de retorno
	WSDATA cRet             AS STRING OPTIONAL
	WSDATA cMessage         AS STRING OPTIONAL


ENDWSSTRUCT


WSSERVICE WSLISTCLIENTES DESCRIPTION "Serviço para listar os dados dos clientes dentro de um intervalo"
    WSDATA cClienteDe     AS STRING 
    WSDATA cCLienteAte    AS STRING

    WSDATA WslistaClientes  AS STlistClientes


    WSMETHOD BuscaClientes  DESCRIPTION "Lista os Clientes da SA1 conforme filtros/parametros especidifcados na entrada"
ENDWSSERVICE

