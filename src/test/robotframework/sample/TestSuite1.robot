*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary
Resource    ../../../main/helperkeywords/assertions.robot

*** Variables ***
${url}      https://www.tst1.bookwana.com/
${createEventButtonLocator}     xpath=//div[@class="flex flex-col md:flex-row"]//a[@class="btn btn--alt md:mr-md mb-sm md:mb-0"]

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
    open browser    ${url}  headlesschrome
    Login process
    close browser

LoginHeadlessFirefox
    [Tags]  LoginBrowserTest
    open browser    ${url}  headlessfirefox
    Login process
    close browser

*** Keywords ***
Provided precondition
    Setup system under test
Headless browser process
    ${title}    Get Title
    ${expected}     Set Variable    Home | TryBooking Australia
    Should Be Equal As Strings  ${title}  ${expected}
    Log     ${title}
Login process
    Click Element    ${createEventButtonLocator}
    click link  xpath://*[@id="login-tab"]/a
    input text  id:Username     justin@bookwana.com
    input text  id:Password     1password
    Press Keys  id:Password     ENTER
    Wait Until Page Contains    Justin_Test