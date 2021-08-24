*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary
Resource    ../../../main/helperkeywords/assertions.robot

*** Variables ***
${url}      https://portal.tst1.bookwana.com/au/auth
${createEventButtonLocator}     xpath=//a[@text="Create Event"]

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

ThirdPartySiteSample
    open browser    https://demo.nopcommerce.com/
    click link  xpath://a[@class='ico-login']
    input text  id:Email    pavanoltraining@gmail.com
    input text  id:Password     Test@123
    close browser

VisitGoogleHeadlessChrome
    [Tags]  HeadlessBrowserTest
    open browser    ${url}  chrome
    Headless browser process
    close browser

VisitGoogleHeadlessFirefox
    [Tags]  HeadlessBrowserTest
    open browser    ${url}  firefox
    Headless browser process
    close browser

LoginHeadlessChrome
    [Tags]  LoginBrowserTest
    open browser    ${url}  chrome
    Login process
    close browser

LoginHeadlessFirefox
    [Tags]  LoginBrowserTest
    open browser    ${url}  firefox
    Login process
    close browser

*** Keywords ***
Provided precondition
    Setup system under test
Headless browser process
    ${title}    Get Title
    ${expected}     Set Variable    Log in | TryBooking Australia
    Should Be Equal As Strings  ${title}  ${expected}
    Log     ${title}
Login process
    #Click Element    ${createEventButtonLocator}
    #click link  xpath://*[@id="login-tab"]/a
    input text  id:Username     justin@bookwana.com
    input text  id:Password     1password
    Press Keys  id:Password     ENTER
    Wait Until Page Contains    Justin_Test