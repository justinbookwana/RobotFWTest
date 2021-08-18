*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary
Resource    ../../../main/helperkeywords/assertions.robot

*** Variables ***
${url}      https://www.google.com/

*** Test Cases ***
MyFirstTest
    [Tags]  MyFirstTest  HelloWorld
    Log  Hello First World...

MySecondTest
    [Tags]  MySecondTest  HelloWorld
    Log  Hello Second World...

MyThirdTest
    [Tags]  HiThirdWorld  HiWorld
    Log  Hi Third World!

VisitGoogleHeadlessChrome
    [Tags]  HeadlessBrowserTest
    open browser    ${url}  headlesschrome
    Headless browser process
    close browser

VisitGoogleHeadlessFirefox
    [Tags]  HeadlessBrowserTest
    open browser    ${url}  headlessfirefox
    Headless browser process
    close browser

*** Keywords ***
Provided precondition
    Setup system under test
Headless browser process
    click link  xpath://*[@id="gb"]/div/div[1]/div/div[1]/a
    ${title}    Get Title
    ${expected}     Set Variable    Gmail
    String Should Contain  ${title}  ${expected}
    Log     ${title}