*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Variables         locators.py

*** Test Cases ***
Test1
        Open Website

*** Keywords ***
Open Website
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Open Browser    ${DEFAULT_URL}    chrome    options=${chrome_options}      executable_path=${CHROMEDRIVER_PATH}
