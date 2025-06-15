Feature: Task

    As a User 
    I want to see tasks
    So that I can manage tasks

    Background: 
        Given website contain all necessary data

    Scenario: I should see all tasks list
        Given I am currently at homepage
        Then I should see "THITIPORN THAIMJAN" that is opening
        And I should see a button with text "New Task"
        And I should see a button with text "View Brag"
        And I should see a list of tasks
        And each task should show a title and status
    
    Scenario: I can mark a task as completed
        Given I am currently at homepage
        And I see a task with title "Quest: พิมพ์ดีด 55 คำ ต่อนาที 95%"
        When I click the checkbox for "Quest: พิมพ์ดีด 55 คำ ต่อนาที 95%"
        Then the task "Quest: พิมพ์ดีด 55 คำ ต่อนาที 95%" should be marked as completed

    Scenario: I can create a new task
        Given I am currently at homepage
        When I click the "New Task" button
        And I fill in "Title" with "Title with My first task"
        And I click "Create Task"
        Given I am currently at homepage
        Then I should see "Title with My first task" in the task list
        Then I should see the status "⏰ In Progress" for task "Title with My first task"

    @javascript
    Scenario: I can delete a task
        Given I am currently at homepage
        When I click the "New Task" button
        And I fill in "Title" with "Task to delete"
        And I click "Create Task"

        Given I am currently at homepage
        Then I should see "Task to delete" in the task list
        And I should see the status "⏰ In Progress" for task "Task to delete"

        When I click the delete button for "Task to delete"
        And I confirm the deletion

        Then I should not see "Task to delete" in the task list


