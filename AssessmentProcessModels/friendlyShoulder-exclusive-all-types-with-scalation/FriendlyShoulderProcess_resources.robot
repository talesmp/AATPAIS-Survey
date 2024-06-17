*** Settings ***
Library    FakerLibrary    #locale=pt_BR
Library    RPA.Browser.Selenium
Library    String
Library    RPA.Desktop

*** Variables ***
${url_home}    http://localhost:8080/
${url_my_tasks}    ${url_home}my-candidate-tasks
${locator-friendly-shoulder-start-form-babblingCharacterization.type}    friendly-shoulder-start-form-babblingCharacterization
${locator-friendly-shoulder-start-form-date}    friendly-shoulder-start-form-date
${locator-friendly-shoulder-start-form-description}    friendly-shoulder-start-form-description
${locator-task-acknowledge-log}    task-acknowledge-log
${locator-task-acknowledge-response}    task-acknowledge-response
${locator-task-analyse-complaint-gravity}    task-analyse-complaint-gravity
${locator-task-analyse-complaint-log}    task-analyse-complaint-log
${locator-task-analyse-complaint-response}    task-analyse-complaint-response
${locator-task-review-escalation-log}    task-review-escalation-log
${locator-task-review-escalation-response}    task-review-escalation-response

*** Keywords ***
The user logs in
    [Documentation]  
    [Arguments]  
    Open Available Browser    maximized=true
    Go To    ${url_home}
    Click Element When Visible       account-menu__BV_toggle_
    Click Element When Visible       login
    Wait Until Element Is Visible    login-page___BV_modal_header_
    Input Text When Element Is Visible    username    admin
    Input Text When Element Is Visible    password    admin
    Click Element When Visible    //span[contains(.,'Remember me')]
    Click Button When Visible    //button[@data-cy='submit'][contains(.,'Sign in')]
    Sleep    500ms

The user is in MyTasks
    [Documentation]  
    [Arguments]  
    Sleep    500ms
    Go To    ${url_my_tasks}
    Wait Until Element Is Visible    task-instance-heading

The user is in RequestForm
    [Documentation]  
    [Arguments]  
    Sleep    500ms  
    Go To    http://localhost:8080/process-definition/FriendlyShoulderProcess/init 

The user fills RequestForm 
    [Documentation]  
    [Arguments]    ${argRes-description}=${argTest-description}    ${argRes-date}=${argTest-date}    ${argRes-babblingCharacterization.type}=${argTest-babblingCharacterization.type} 
    Wait Until Page Contains    Create or edit a 
    Input Text When Element Is Visible    ${locator-friendly-shoulder-start-form-description}    ${argRes-description} 
    Input Text When Element Is Visible    ${locator-friendly-shoulder-start-form-date}    ${argRes-date} 
    Click Element When Visible    ${locator-friendly-shoulder-start-form-babblingCharacterization.type} 
    IF    '${argRes-babblingCharacterization.type}'=='blindExecutionSelection'
        ${list_options}=    Get WebElements    //select[@id='${locator-friendly-shoulder-start-form-babblingCharacterization.type}']/option 
        ${options_length}=    Get Length    ${list_options} 
        ${random_index}=    Random Int    1    ${options_length - 1} 
        Select From List By Index    ${locator-friendly-shoulder-start-form-babblingCharacterization.type}    ${random_index} 
    ELSE 
        Click Element When Visible     //option[@value='[object Object]'][contains(.,'${argRes-babblingCharacterization.type}')]  
    END 

The user submits RequestForm
    [Documentation]  
    [Arguments]  
    Sleep    500ms  
    Capture Page Screenshot  
    Click Button    save-entity 

The user is in TaskAnalyseComplaint
    [Documentation]  
    [Arguments]  
    Sleep    500ms  
    Click Element If Visible    xpath:/html[1]/body[1]/div[1]/div[3]/div[1]/div[1]/div[1]/div[2]/table[1]/tbody[1]/tr[1]/td[12]/div[1]/button[1]  
    Wait Until Page Contains    TaskAnalyseComplaint

The user fills TaskAnalyseComplaint 
    [Documentation]  
    [Arguments]    ${argRes-gravity}=${argTest-gravity}    ${argRes-log}=${argTest-log}    ${argRes-response}=${argTest-response} 
    Wait Until Page Contains    TaskAnalyseComplaint 
    Input Text When Element Is Visible    ${locator-task-analyse-complaint-gravity}    ${argRes-gravity} 
    IF    ${argRes-log} is True 
        Wait Until Element Is Visible    ${locator-task-analyse-complaint-log} 
        Select Checkbox    ${locator-task-analyse-complaint-log} 
    ELSE IF    ${argRes-log} is False 
        Wait Until Element Is Visible    ${locator-task-analyse-complaint-log} 
        Unselect Checkbox    ${locator-task-analyse-complaint-log} 
    END 
    Input Text When Element Is Visible    ${locator-task-analyse-complaint-response}    ${argRes-response} 

The user submits TaskAnalyseComplaint
    [Documentation]  
    [Arguments]  
    Sleep    500ms  
    Capture Page Screenshot  
    Click Button    //button[@type='submit'][contains(.,'Complete')] 

The user is in TaskReviewEscalation
    [Documentation]  
    [Arguments]  
    Sleep    500ms  
    Click Element If Visible    xpath:/html[1]/body[1]/div[1]/div[3]/div[1]/div[1]/div[1]/div[2]/table[1]/tbody[1]/tr[1]/td[12]/div[1]/button[1]  
    Wait Until Page Contains    TaskReviewEscalation

The user fills TaskReviewEscalation 
    [Documentation]  
    [Arguments]    ${argRes-log}=${argTest-log}    ${argRes-response}=${argTest-response} 
    Wait Until Page Contains    TaskReviewEscalation 
    IF    ${argRes-log} is True 
        Wait Until Element Is Visible    ${locator-task-review-escalation-log} 
        Select Checkbox    ${locator-task-review-escalation-log} 
    ELSE IF    ${argRes-log} is False 
        Wait Until Element Is Visible    ${locator-task-review-escalation-log} 
        Unselect Checkbox    ${locator-task-review-escalation-log} 
    END 
    Input Text When Element Is Visible    ${locator-task-review-escalation-response}    ${argRes-response} 

The user submits TaskReviewEscalation
    [Documentation]  
    [Arguments]  
    Sleep    500ms  
    Capture Page Screenshot  
    Click Button    //button[@type='submit'][contains(.,'Complete')] 

The user is in TaskAcknowledge
    [Documentation]  
    [Arguments]  
    Sleep    500ms  
    Click Element If Visible    xpath:/html[1]/body[1]/div[1]/div[3]/div[1]/div[1]/div[1]/div[2]/table[1]/tbody[1]/tr[1]/td[12]/div[1]/button[1]  
    Wait Until Page Contains    TaskAcknowledge

The user fills TaskAcknowledge 
    [Documentation]  
    [Arguments]    ${argRes-log}=${argTest-log}    ${argRes-response}=${argTest-response} 
    Wait Until Page Contains    TaskAcknowledge 
    IF    ${argRes-log} is True 
        Wait Until Element Is Visible    ${locator-task-acknowledge-log} 
        Select Checkbox    ${locator-task-acknowledge-log} 
    ELSE IF    ${argRes-log} is False 
        Wait Until Element Is Visible    ${locator-task-acknowledge-log} 
        Unselect Checkbox    ${locator-task-acknowledge-log} 
    END 
    Input Text When Element Is Visible    ${locator-task-acknowledge-response}    ${argRes-response} 

The user submits TaskAcknowledge
    [Documentation]  
    [Arguments]  
    Sleep    500ms  
    Capture Page Screenshot  
    Click Button    //button[@type='submit'][contains(.,'Complete')] 

