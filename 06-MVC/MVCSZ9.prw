#include 'totvs.ch'
#include 'FWMVCDEF.ch'
#include 'TBICONN.ch'

user function MVCSZ9()
	local aArea := GetNextAlias()
	local oBrowseSZ9

	oBrowseSZ9 := FWMbrowse():new()

	oBrowseSZ9:SetAlias("SZ9")

	oBrowseSZ9:AddLegend("SZ9->Z9_STATUS == '1'","GREEN","Protheuzeiro Ativo")
	oBrowseSZ9:AddLegend("SZ9->Z9_STATUS == '2'","RED","Protheuzeiro Inativo")

	oBrowseSZ9:Activate()

	RestArea(aArea)
RETURN

user function PMVCSZ9()
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
	DEFINE WINDOW oMainWnd FROM 001,001 TO 400,500 TITLE 'Janela Principal'

	ACTIVATE WINDOW oMainWnd MAXIMIZED ON INIT ( U_MVCSZ9() , oMainWnd:End() )

	RESET ENVIRONMENT
return

