*** Settings ***
Library           robot.libraries.Collections._List
Library           Selenium2Library

*** Variables ***
${BROWSER}        Firefox
${URL}			http://testiapp-demoapp-test.cloudapps.ocp-teco.teco.prd.a.tecdomain.net/#/
${USERNAME_A}       admin
${PWD_A}		    admin
${USERNAME_U}       user
${PWD_U}		    user


*** Keywords ***

Test Config
    Set Selenium Timeout    30
    Set Selenium Speed    0.0s


Open Page
    [Documentation]    Opens browser to login page
    Open Browser    ${URL}    ${BROWSER}
    Set Window Size    1024    768
    Title Should Be    demoapp
	
	
*** Test Cases ***
BrowseLinks
    [Documentation]    Browse through the links in testsite
    [Setup]    Test Config

    Open Page 

	Sleep    3s
	Click Link   Register a new account
	Click Link 	 sign in
	
#    Input Text    xpath=//input[@id='password']   ${USERNAME_A}    
#    Input Text    xpath=//input[@id='password']    ${PWD_A} 
#    Click Element    //*[@type='submit']
#	 Wait Until Element Is Visible    //div[.='You are logged in as user "admin".']
	
	Close Browser

	
*** Test Cases ***
SignInPage
    [Documentation]   Visit sign in page 
    [Setup]    Test Config

    Open Page
	Sleep    3s	
	Click Link	sign in
	
#    Input Text    xpath=//input[@id='password']   ${USERNAME_A}    
#    Input Text    xpath=//input[@id='password']    ${PWD_A} 
#    Click Element    //*[@type='submit']
#	 Wait Until Element Is Visible    //div[.='You are logged in as user "admin".']
	
	Close Browser

*** Test Cases ***
RegistrationPage
    [Documentation]   Visit registration page 
    [Setup]    Test Config

    Open Page 
	Sleep    3s
	Click Link   Register a new account
	
#	 Wait Until Element Is Visible    //h1[.='Registration']
	
	Close Browser

	