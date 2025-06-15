Given("website contain all necessary data") do
  Rails.application.load_seed
end

Given('I am currently at homepage') do
  visit root_path
end

Then('I should see {string} that is opening') do |string|
  expect(page).to have_css("[data-testid='hero-heading']", text: string)
end

Then('I should see a button with text {string}') do |string|
  expect(page).to have_content(string)
end

Then('I should see a list of tasks') do
  expect(page).to have_css("[data-testid^='task-container-']", minimum: 1)
end

Then('each task should show a title and status') do
  task_containers = all("[data-testid^='task-container-']")

  task_containers.each do |task|
    task_id = task[:'data-testid'].split('-').last

    title_selector = "[data-testid='task-title-#{task_id}']"
    status_selector = "[data-testid='task-status-#{task_id}']"

    expect(task).to have_css(title_selector)
    expect(task.find(title_selector).text).not_to be_empty

    expect(task).to have_css(status_selector)
    expect(task.find(status_selector).text).not_to be_empty
  end
end

Given('I see a task with title {string}') do |string|
  expect(page).to have_content(string)
end

When('I click the checkbox for {string}') do |string|
  task = find("[data-testid^='task-container-']", text: string)
  task.find("[data-testid^='task-checkbox-']").click
end

Then('the task {string} should be marked as completed') do |string|
  task = find("[data-testid^='task-container-']", text: string)
  checkbox = task.find("input[type='checkbox']")
  expect(checkbox).to be_checked
end

When('I click the {string} button') do |string|
  find("[data-testid='new-task-button']").click
end

When('I fill in {string} with {string}') do |field, value|
  testIdMap = {
    "Title" => "task-title-input"
  }
  testid = testIdMap[field]
  if testid.nil?
    # fallback ใช้ fill_in แบบปกติ (label หรือ name)
    fill_in field, with: value
  else
    find("[data-testid='#{testid}']").set(value)
  end
end

When('I click {string}') do |string|
  find("[data-testid='task-submit-button']").click
end

Then('I should see {string} in the task list') do |string|
  expect(page).to have_content(string)
end

Then('I should see the status {string} for task {string}') do |status_text, task_title|
  task_container = find("[data-testid^='task-container-']", text: task_title)
  task_id = task_container[:'data-testid'].split('-').last
  expect(page).to have_css("[data-testid='task-status-#{task_id}']", text: status_text)
end

When('I click the delete button for {string}') do |title|
  task = all("[data-testid^='task-container-']").find do |container|
    container.has_css?("[data-testid^='task-title-']", text: title)
  end

  raise "Task with title '#{title}' not found" unless task

  page.accept_confirm do
    task.find("[data-testid^='task-delete-button-']").click
  end
end

And('I confirm the deletion') do
  # ไม่ต้องทำอะไรแล้ว เพราะจัดการใน accept_confirm ด้านบนไปแล้ว
end

Then('I should not see {string} in the task list') do |title|
  expect(page).not_to have_content(title)
end
