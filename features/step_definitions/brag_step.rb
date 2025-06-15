When('I click the {string}') do |string|
  find("[data-testid='view-brag-button']").click
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end
