*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String

Suite Teardown   Close All Browsers

*** Variable ***
${url_todolist}             https://abhigyank.github.io/To-Do-List/
${title_todolist}           To-Do List
${header_additem}           //*[@href="#add-item"]
${input_additem}            //*[@class="mdl-textfield__input"]
${testTxt1}                 1st task
${btn_additem}              //button//*[text()="add"]
${header_todo}              //*[@href="#todo"]
${item_todo}                //ul[@id="incomplete-tasks"]/li
${complete_todo}            //ul[@id="incomplete-tasks"]/li/label//span[@id="text-1"]
${del_todo}                 //ul[@id="incomplete-tasks"]//button[text()="Delete"]
${header_completed}         //*[@href="#completed"]
${item_completed}           //ul[@id="completed-tasks"]/li
${complete_completed}       //ul[@id="completed-tasks"]/li//span[text()="${testTxt1}"]
${del_completed}            //ul[@id="completed-tasks"]/li//span[text()="${testTxt1}"]/following-sibling::button[text()="Delete"]

*** Keywords ***
Verify website
    [Arguments]                ${title}      ${xpath_additem}       ${xpath_todo}       ${xpath_completed}
    Title Should Be            ${title}
    Element Should Be Visible    ${xpath_additem}
    Element Should Be Visible    ${xpath_todo}
    Element Should Be Visible    ${xpath_completed}
Create task
     [Arguments]      ${xpath_additem}     ${xpath_input}      ${task}
     Element Should Be Visible    ${xpath_additem}
     Click Element                ${xpath_additem}
     Element Should Be Visible    ${xpath_input}
     Input Text                   ${xpath_input}       ${task}
Click Create task
     [Arguments]      ${xpath_btn} 
     Element Should Be Visible    ${xpath_btn}
     Click Element                  ${xpath_btn}
Verify create success
   [Arguments]        ${xpath_item}      ${xpath_todo} 
   Element Should Be Visible        ${xpath_todo}
   Click Element                    ${xpath_todo}
   Element Should Be Visible        ${xpath_item}
Click Complete task
     [Arguments]      ${xpath_task} 
     Element Should Be Visible    ${xpath_task}
     Click Element                ${xpath_task}
Verify complete task success
   [Arguments]        ${xpath_item_comp}      ${xpath_completed}    ${xpath_item}  
   Wait Until Element Is Not Visible   ${xpath_item}
   Element Should Be Visible            ${xpath_completed}
   Click Element                        ${xpath_completed}
   Element Should Be Visible            ${xpath_item_comp}
Click Delete task
     [Arguments]      ${xpath_del_task} 
     Element Should Be Visible    ${xpath_del_task}
     Click Element                ${xpath_del_task}
Verify delete task success
   [Arguments]        ${xpath_item}
   Element Should Not Be Visible  ${xpath_item}

*** Test Cases ***
Create and Complete the task
    [tags]    Success
    Open Browser    about:blank    chrome
    Go To                     ${url_todolist}
    Verify website            ${title_todolist}  ${header_additem}  ${header_todo}  ${header_completed}
    Create task               ${header_additem}  ${input_additem}  ${testTxt1}
    Click Create task         ${btn_additem}
    Verify create success     ${item_todo}  ${header_todo}
    Click Complete task       ${complete_todo}
    Verify complete task success  ${complete_completed}  ${header_completed}   ${item_todo}

Create, Complete and Delete the task
    [tags]    Success
    Open Browser    about:blank    chrome
    Go To                     ${url_todolist}
    Verify website            ${title_todolist}  ${header_additem}  ${header_todo}  ${header_completed}
    Create task               ${header_additem}  ${input_additem}  ${testTxt1}
    Click Create task         ${btn_additem}
    Verify create success     ${item_todo}  ${header_todo}
    Click Complete task       ${complete_todo}
    Verify complete task success  ${complete_completed}  ${header_completed}   ${item_todo}
    Click Delete task             ${del_completed}
    Verify delete task success  ${complete_completed}

Create and Delete the task
    [tags]    Success
    Open Browser    about:blank    chrome
    Go To                     ${url_todolist}
    Verify website            ${title_todolist}  ${header_additem}  ${header_todo}  ${header_completed}
    Create task               ${header_additem}  ${input_additem}  ${testTxt1}
    Click Create task         ${btn_additem}
    Verify create success     ${item_todo}  ${header_todo}
    Click Delete task         ${del_todo}
    Verify delete task success  ${item_todo}