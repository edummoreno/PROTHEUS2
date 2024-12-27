#INCLUDE 'TOTVS.CH'

USER FUNCTION AULAIF()
	LOCAL nNum1:= 1,nNum2 := 2

    
	IF nNum2 < nNum1
        FWAlertINFO("O NUMERO "+cValtochar(nNum1)+" E MAIOR QUE "+cValtochar(nNum2),"INFO")
	elseif nNum1 < nNum2
        FWAlertINFO("O NUMERO "+cValtochar(nNum2)+" E MAIOR QUE "+cValtochar(nNum1),"INFO")
	else
        FWAlertINFO("Os numeros são iguais","INFO")
	ENDIF
    
    IiF(nNum2 < nNum1,;
    FWAlertINFO("O NUMERO "+cValtochar(nNum1)+" E MAIOR QUE "+cValtochar(nNum2),"INFO"),;
    Iif(nNum1 < nNum2,FWAlertINFO("O NUMERO "+cValtochar(nNum2)+" E MAIOR QUE "+cValtochar(nNum1),"INFO"),;
    FWAlertINFO("Os numeros são iguais","INFO")))

RETURN
