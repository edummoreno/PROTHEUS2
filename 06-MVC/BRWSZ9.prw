#include 'totvs.ch'
#include 'TBICONN.CH'
#include 'FWMVCDEF.ch'

/*/{Protheus.doc} nomeFunction
    MVC modelo 1
    @type  Function
    @author user
    @since 07/03/2024
    /*/
user Function BRWSZ9()
	//LOCAL aArea := GetNextAlias()
	local oBrowseSZ9 //objeto que receberá o instanciamento da classe FwMrowse

	//Objeto que recebe classe FwMbrowse QUE RECEBE O METÓDO NEW
	oBrowseSZ9 := FwMBrowse():new()

	//passo como parametro a tabela que eu quero mostrar no browse
	oBrowseSZ9:SetAlias("SZ9")

	//descrição
	oBrowseSZ9:SetDescription("Tela de Protheuzeiros sz9")

	//adiciona legenda aquele botãozinho colorido
	oBrowseSZ9:addlegend("SZ9->Z9_STATUS == '1' ","GREEN","Protheuszeiro Ativo" )
	oBrowseSZ9:addlegend("SZ9->Z9_STATUS == '2' ","RED","Protheuszeiro Inativo" )

	//mostra apenas o campos especificados
	oBrowseSZ9:SetOnlyFields({"Z9_CODIGO","Z9_NOME","Z9_SEXO","Z9_STATUS"})

	//filtra
	//oBrowseSZ9:SetFilterDefault("Z9_STATUS == '1' ")

	//desabilida os detalhes em baixo
	oBrowseSZ9:DisableDetails()

	oBrowseSZ9:Activate()

	//RestArea(aArea)
Return

/*/{Protheus.doc} MenuDef
MenuDef resumidamente tras os botões
@type function
@version 1.0 
@author edumn
@since 22/03/2024
/*/
static function MenuDef()
	local aRotina := {}

	ADD OPTION aRotina TITLE "Visualizar" ACTION 'VIEWDEF.BRWSZ9' OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir"    ACTION 'VIEWDEF.BRWSZ9' OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar"    ACTION 'VIEWDEF.BRWSZ9' OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir"    ACTION 'VIEWDEF.BRWSZ9' OPERATION 5 ACCESS 0
	ADD OPTION aRotina TITLE "Legenda"    ACTION 'U_SZ9LEG' OPERATION 6 ACCESS 0


	/*
	1 - pesquisar
	2 - visualizar
	3 - incluir
	4 - alterar
	5 - excluir
	6 - outras funções
	7 - copiar
	*/
return aRotina

/*/{Protheus.doc} ModelDef
Static function modeldef "modelo de dados" "trata as regras de negócios de dados"
@type function
@version 1.0
@author edumn
@since 19/03/2024
/*/
static function ModelDef()
	local oStructSZ9 := NIL
	local oModel     := NIL
	local aChave

	//classe // Oque $ faz?
	//1 quando é model, 2 quando é view
	//tras a estrutura da SZ9 tabela a tabela e caracteristicas dos campos
	oStructSZ9 := FWFormSctruct():new(1,'SZ9')//,{|x| alltrim(x) $ 'Z9_STATUS'})

	//Instanciando a classe MPFormModel
	//BRWSZ9M Identificador do modelo
	//https://tdn.totvs.com/pages/releaseview.action?pageId=552574620
	oModel := MPFormModel():new("BRWSZ9M",/*bPre*/,/*bPos*/,/*bCommit*/,/*bCancel*/)

	//chama metódo AddFields(< cId >, < cOwner >, < oModelStruct >, < bPre >, < bPost >, < bLoad >)
	oModel:AddFields("FORMSZ9",/*Owner*/,oStruSZ9)

	aChave := {"Z9_FILIAL","Z9_CODIGO"}

	//chave Primária
	oModel:SetPrimarykey(aChave)

	//descrição
	oModel:SetDescription("MVC modelo 1 tabela SZ9")

	//ID do objeto de for deixado vazio retornará o proprio model?
	oModel:GetModel("FORMSZ9"):SetDescription("Formulário de cadastro Protheuzeiro(a)")

	//para retirar o alerta var nunca usada
	oModel := NIL
return oModel

/*/{Protheus.doc} ViewDef
Constroi a visualização 
@type function
@version  1.0
@author edumn
@since 20/03/2024
/*/
static function ViewDef
	local oModel := ModelDef()
	local oStructSZ9 := NIL
	local oView := NIL

/*-------------------------------PRINCIPAIS-----------------------------------------------------------------*/
	//funcao que retorna um objeto de determinado fonte. //carrega o modelo de dados no oModel
	oModel := FWLoadModel("MVCSZ9")

	//tras a estrutura da SZ9 "1 MODEL | 2 VIEW"
	oStructSZ9 := FWFormSctruct(2,"SZ9")

	//Construindo a parte de Visão dos dados
	oView := FWFormView():new()

/*-------------------------------PRINCIPAIS-----------------------------------------------------------------*/

	oView:SetModel(oModel)

	//Atribuição da estrutura de dados a camada de visao
	oView:AddField("VIEWSZ9",oStructSZ9,"FORMSZ9")

	//cria um box horizontal dentro do container do view
	oView:CreateHorizontalBox("Tela",100)

	//Adicionando Titulo ao Formulario
	oView:EnableTitleView("VIEWSZ9","Visualizacao dos protheuzeiros")

	//Força o fechamento da janela passando o parametro .T.
	oView:SetCloseOnOK({||.T.})

	//
	oView:SetOwnerView("VIEWSZ9","Tela")
return oView


user function PBRWSZ9()
	//VERIFICA SE O SISTEMA ESTÁ RODANDO SEM INTERFACE // SE .T. SEM, SE .F. COM
	IF IsBlind()

		PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

		DEFINE WINDOW oMainWnd FROM 001,001 TO 400,500 TITLE 'Janela Principal'

		ACTIVATE WINDOW oMainWnd MAXIMIZED ON INIT( U_BRWSZ9() , oMainWnd:End() )

		RESET ENVIRONMENT

	else
		U_BRWSZ9()
	ENDIF
return
//atenção função so pode ter 8 caracteres se não da erro
user function SZ9LEG()
	local aLegenda := {}

	//add(aLegenda,{"BR_VERDE", "ATIVO"})
	//add(aLegenda,{"BR_VERMELHO", "INATIVO"})

	//@see https://terminaldeinformacao.com/knowledgebase/brwlegenda/
	//BrwLegenda("Protheuzeiro(as)","Ativos/Inativos",aLegenda)
	aLegenda := "<b>teste<\b>"

	FWAlertInfo(aLegenda,"legenda")
	

RETURN aLegenda
