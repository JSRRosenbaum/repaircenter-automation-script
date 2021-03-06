#include <GUIConstantsEx.au3>

#include <MsgBoxConstants.au3>
#include <IE.au3>

rshmrLoginGui ()

Func rshmrLoginGui()

	Local $hGUI = GUICreate("Login", 170, 100)			; Create a GUI with various controls.

	Local $itechID, $iPW  													; Initialize Vars : text input

	Local $techID, $PW														; Initialize Vars : pass to roupdate

    GUICtrlCreateLabel("Tech ID :", 10, 20)							; Label and Entry fields
	$itechID = GUICtrlCreateInput("", 75, 15, 75, 20)

	GUICtrlCreateLabel("Password :", 10, 50)
	$iPW = GUICtrlCreateInput("", 75, 45, 75, 20)

	Local $iUPDATE = GUICtrlCreateButton( "Log me in", 50, 70, 75, 25)		; Create Update button

	GUISetState(@SW_SHOW, $hGUI)											; Display the GUI.

	While 1																	; Loop until the user exits.
		Switch GUIGetMsg()

			Case $iUPDATE
			   $techID = GUICtrlRead( $itechID )							; Copy user inputs to Var
			   $PW = GUICtrlRead( $iPW )

			   rshmrlogin ($techID, $PW) 							; Call rologin

			   Sleep(1000)													; Wait for 1000 ms

			   rshmrsetup ($techID)										; Setup MS screen

			Case $GUI_EVENT_CLOSE

			; Delete the previous GUI and all controls.
			GUIDelete($hGUI)

			ExitLoop
		EndSwitch
	 WEnd
EndFunc

Func rshmrlogin($iUID, $iPW)
   Local $oIE , $hwnd, $oForm, $oQuery, $oHref

   $oIE = _IECreate("http://10.49.40.11/", 0, 1, 1, 1)

   _IELoadWait($oIE)

   $oForm = _IEGetObjByName($oIE, "Form2")

   $oQuery = _IEFormElementGetObjByName($oForm, "txtUserID")
   _IEFormElementSetValue($oQuery, $iUID)
   $oQuery = _IEFormElementGetObjByName($oForm, "txtPassword")
   _IEFormElementSetValue($oQuery, $iPW)

   $oQuery = _IEFormElementGetObjByName($oForm, "cmdLogin")
   _IEAction($oQuery, "Click")

   Sleep(1000)

   ControlSend("", "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "{Enter}")
EndFunc

Func rshmrsetup($iUID)
   Local $oIE , $hwnd, $oForm, $oQuery

   _IECreate("http://10.49.40.11/MYSERVICE/ER/ST/ERST001.ASPX", 1, 1, 1, 1) ;System Repair
   _IECreate("http://10.49.40.11/MYSERVICE/ER/RO/ERRO001.ASPX", 1, 1, 1, 0) ;Repair Order create and maintain
   _IECreate("http://10.49.40.11/MYSERVICE/ER/REPORT/ER003W0.ASPX", 1, 1, 1, 0) ;Engineer output report
   ;_IECreate("http://10.49.40.11/MYSERVICE/SM/REPORT/SM016C0.ASPX?SERVICEM=P", 1, 1, 1, 0) ;WUR Status Inquiry

   $oIE = _IEAttach("Untitled")
   $oForm = _IEGetObjByName($oIE, "form1")

    $oQuery = _IEFormElementGetObjByName($oForm, "txtEngID")
   _IEFormElementSetValue($oQuery, $iUID)



EndFunc