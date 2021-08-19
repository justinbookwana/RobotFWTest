*** Settings ***

*** Variables ***
${3s}   3s
${5s}   5s
${10s}  10s
${15s}  30s
${60s}  120s
${20s}  60s
${30s}  80s
${40s}  90s
${XPATH_SPINNER}                    //*[@id="spinner-target"]/div


*** Keywords ***
#WAIT
Sleep Until Element Is Visible
    [Arguments]  ${locator}  ${time}  ${capture?}=no
    Run Keyword If  '${capture?}'=='yes'  Capture Page Screenshot
    ${status}  Run Keyword And Return Status  Wait Until Element Is Visible  ${locator}  ${time}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Element ${locator} is not visible in ${time}!

Sleep Until Element Is Not Visible
    [Arguments]  ${locator}  ${time}  ${capture?}=no
    ${status}  Run Keyword And Return Status  Wait Until Element Is Not Visible  ${locator}  ${time}
    Run Keyword If  '${capture?}'=='yes'  Capture Page Screenshot
    Run Keyword If  '${status}'!='True'  Capture And Fail  Element ${locator} is still visible after ${time}!

Sleep Until Element Is Clickable
    [Arguments]  ${locator}  ${time}
    Sleep Until Element Is Clickable NP  ${locator}  ${time}

Sleep Until Element Is Clickable OP
    [Arguments]  ${locator}  ${time}
    ${status}  Run Keyword And Return Status  Wait Until Element Is Clickable  ${locator}  ${time}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Element ${locator} is not clickable in ${time}!

Sleep Until Element Is Not Clickable
    [Arguments]  ${locator}  ${time}
    Sleep Until Element Is Not Clickable NP  ${locator}  ${time}

Sleep Until Element Is Not Clickable OP
    [Arguments]  ${locator}  ${time}
    ${status}  Run Keyword And Return Status  Wait Until Element Is Not Clickable  ${locator}  ${time}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Element ${locator} is still clickable after ${time}!

Sleep Until Page Contains Text
    [Arguments]  ${text}  ${time}
    ${status}  Run Keyword And Return Status  Wait Until Page Contains  ${text}  ${time}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Page does not contain ${text} in ${time}!

Sleep Until Page Does Not Contain Text
    [Arguments]  ${text}  ${time}
    ${status}  Run Keyword And Return Status  Wait Until Page Not Contains  ${text}  ${time}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Page still contains ${text} after ${time}!

Sleep Until Element Is Clicked
    [Arguments]  ${locator}  ${time}
    ${status}  Run Keyword And Return Status  Wait Until Element Is Successfully Clicked  ${locator}  ${time}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Element ${locator} is not clickable in ${time}!

Sleep Until Page Contains Element
    [Arguments]  ${locator}  ${time}
    ${status}  Run Keyword And Return Status  Wait Until Page Contains Element  ${locator}  ${time}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Page does not contain element ${locator} in ${time}!

Sleep Until Page Does Not Contain Element
    [Arguments]  ${locator}  ${time}
    ${status}  Run Keyword And Return Status  Wait Until Page Not Contains Element  ${locator}  ${time}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Page still contains element ${locator} after ${time}!

Sleep Until Page Is Loaded  #waits until spinner is no longer visible
    Sleep  2
    ${status}  Run Keyword And Return Status  Element Should Be Visible  ${XPATH_SPINNER}
    Run Keyword If  ${status}  Sleep Until Element Is Not Visible  ${XPATH_SPINNER}  ${40s}

Sleep Until Page Is Ready  #waits until page is ready and loaded (no loading icon on the title bar)
    :FOR  ${INDEX}  IN RANGE  0  5
    \  ${ready}  Execute Javascript  return document.readyState === "complete"
    \  Run Keyword If  '${ready}'!='True'  Sleep  3
    \  Exit For Loop If  '${ready}'=='True'
    Run Keyword If  '${ready}'!='True'  Capture And Fail  Page is not responding for ${60s}!

Sleep Until Portal Beta Page Is Ready  #waits until elements are already loaded in the portal beta page
    [Arguments]  ${time}
    ${time}  Remove String  ${time}  s
    ${time}  Convert To Integer  ${time}
    :FOR  ${INDEX}  IN RANGE  0  ${time}
    \  ${notready}  Execute Javascript  return document.getElementById('cdk-describedby-message-container')==null
    \  Run Keyword If  '${notready}'=='True'  Sleep  1
    \  Exit For Loop If  '${notready}'=='False'
    Run Keyword If  '${notready}'=='True'  Capture And Fail  Page is not responding for ${time}!

Sleep Until Portal Beta Page Is Loaded  #waits until circle spinner is no longer visible (portalbeta)
    [Arguments]  ${capture?}=no
    Sleep  1
    ${status}  Execute Javascript  return document.getElementsByTagName('mat-spinner').length;
    Run Keyword If  ${status}>0  Sleep Until Portal Beta Page Is Loaded


Sleep Until Element Is Clickable NP
    [Arguments]  ${locator}  ${times}
    ${times}  Remove String  ${times}  s
    ${counter}  Evaluate  ${times}-1
    Sleep Until Element Is Visible  ${locator}  ${times}
    :FOR  ${INDEX}  IN RANGE  0  ${times}
    \  ${status}  Run Keyword and Return Status  Element Should Be Clickable  ${locator}
    \  Run Keyword If  '${status}'!='True' and ${INDEX}!=${counter}  Sleep  1s
    \  ...  ELSE IF  '${status}'!='True' and ${INDEX}==${counter}  Capture And Fail  Element ${locator} is not clickable in ${times}s
    \  ...  ELSE IF  '${status}'=='True'  Exit For Loop
#    Sleep  1

Sleep Until Element Is Clickable NP Mobile
    [Arguments]  ${locator}  ${times}
    ${times}  Remove String  ${times}  s
    ${counter}  Evaluate  ${times}-1
    Sleep Until Element Is Visible  ${locator}  ${times}
    :FOR  ${INDEX}  IN RANGE  0  ${times}
    \  ${status}  Run Keyword and Return Status  Element should be enabled  ${locator}
    \  Run Keyword If  '${status}'!='True' and ${INDEX}!=${counter}  Sleep  1s
    \  ...  ELSE IF  '${status}'!='True' and ${INDEX}==${counter}  Capture And Fail  Element ${locator} is not clickable in ${times}s
    \  ...  ELSE IF  '${status}'=='True'  Exit For Loop

Sleep Until Element Is Not Clickable NP
    [Arguments]  ${locator}  ${times}
    ${times}  Remove String  ${times}  s
    ${counter}  Evaluate  ${times}-1
    :FOR  ${INDEX}  IN RANGE  0  ${times}
    \  ${status}  Run Keyword And Return Status  Element Should Not Be Clickable  ${locator}
    \  Run Keyword If  '${status}'!='True' and ${INDEX}!=${counter}  Sleep  1s
    \  ...  ELSE IF  '${status}'!='True' and ${INDEX}==${counter}  Capture And Fail  Element ${locator} is clickable in ${times}s
    \  ...  ELSE IF  '${status}'=='True'  Exit For Loop


Sleep Until User Is Back To NP Dashboard
    [Arguments]  ${time}  ${eid}=${EID}
    ${time}  Remove String  ${time}  s
    ${url}  Replace  ${eid}  ${URL_PORTALBETA_EVENT_DASHBOARD}
    :FOR  ${INDEX}  IN RANGE  0  ${time}
    \  Sleep  1
    \  ${loc}  Get Location
    \  ${status}  Run Keyword And Return Status  Should Be Equal  ${url}  ${loc}
    \  Run Keyword If  '${status}'!='True'  Sleep Until User Is Back To NP Dashboard  ${time}  eid=${eid}
    \  ...  ELSE  Exit For Loop

Sleep Until Dropdown Is Ready NP
    [Arguments]  ${dropdown_id}  ${dropdown_table}
    Sleep Until Element Is Clickable  ${dropdown_id}  ${15s}
    Sleep  1
    Click  ${dropdown_id}
    ${status}  Run Keyword And Return Status  Element Should Be Visible  ${dropdown_table}  ${15s}
    Run Keyword If  '${status}'!='True'  Sleep Until Dropdown Is Ready NP  ${dropdown_id}  ${dropdown_table}
    ...  ELSE IF  '${status}'=='True'  Click  ${dropdown_id}

Sleep Until Verification Message Is Displayed
    [Arguments]  ${locator}  ${expectedmessage}
    ${time}  Remove String  ${20s}  s
    ${counter}  Evaluate  ${time}-1
    Sleep Until Element Is Visible  ${locator}  ${time}
    :FOR  ${INDEX}  IN RANGE  0  ${time}
    \    ${message}  Get Text  ${locator}
    \    Run Keyword If  '${message}'=='${EMPTY}' and '${INDEX}'!='${counter}'  Sleep  1s
    \    ...  ELSE IF  '${message}'=='${EMPTY}' and '${INDEX}'=='${counter}'  Capture And Fail  No Message Found in ${time}s
    \    ...  ELSE IF  '${message}'!='${EMPTY}'  Exit For Loop
    Sleep  ${5s}
    ${message}  Get Text  ${locator}
    String Should Be Equal  ${message}  ${expectedmessage}

Sleep Until Record Is Successfully Saved
    Sleep Until Page Contains Text  Record successfully saved.  ${15s}

Sleep Until Record Is Successfully Updated
    Sleep Until Page Contains Text  Record successfully updated.  ${15s}

Sleep Until Page Is Ready For Login Logout
    Sleep  1
    ${status1}  Run Keyword And Return Status  Sleep Until Portal Beta Page Is Ready  ${5s}
    ${status2}  Run Keyword And Return Status  Sleep Until Element Is Visible  ${ID_PORTAL_EMAIL_FIELD}  ${5s}
    ${status3}  Run Keyword And Return Status  Sleep Until Element Is Visible  Username  ${5s}
    Run Keyword If  '${status1}'!='True' and '${status2}'!='True' and '${status3}'!='True'  Sleep Until Page Is Ready For Login Logout


#ASSERTIONS
String Should Contain
    [Arguments]  ${text}  ${contains}  ${capture}=yes
    ${status}  Run Keyword And Return Status  Should Contain  ${text}  ${contains}
    Run Keyword If  '${status}'!='True' and '${capture}'=='yes'  Capture And Fail  ${text} does not contain ${contains}!
    ...  ELSE IF  '${status}'!='True' and '${capture}'=='no'  Fail  ${text} does not contain ${contains}!

String Should Not Contain
    [Arguments]  ${text}  ${contains}
    ${status}  Run Keyword And Return Status  Should Not Contain  ${text}  ${contains}
    Run Keyword If  '${status}'!='True'  Capture And Fail  ${text} contains ${contains}!

String Should Be Equal
    [Arguments]  ${string1}  ${string2}  ${capture}=yes
    ${status}  Run Keyword And Return Status  Should Be Equal  ${string1}  ${string2}
    Run Keyword If  '${status}'!='True' and '${capture}'=='yes'  Capture And Fail  ${string1} != ${string2}!
    ...  ELSE IF  '${status}'!='True' and '${capture}'=='no'  Fail  ${text} does not contain ${contains}!

Page Should Contain String
    [Arguments]  ${string}
    ${status}  Run Keyword And Return Status  Page Should Contain  ${string}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Page does not contain ${string}!

Page Should Not Contain String
    [Arguments]  ${string}
    ${status}  Run Keyword And Return Status  Page Should Not Contain  ${string}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Page contains ${string}!

Element Is Displayed
    [Arguments]  ${locator}
    ${status}  Run Keyword And Return Status  Element Should Be Visible  ${locator}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Element ${locator} is not displayed!

Element Is Not Displayed
    [Arguments]  ${locator}
    ${status}  Run Keyword And Return Status  Element Should Not Be Visible  ${locator}
    Run Keyword If  '${status}'!='True'  Capture And Fail  Element ${locator} is still displayed!



