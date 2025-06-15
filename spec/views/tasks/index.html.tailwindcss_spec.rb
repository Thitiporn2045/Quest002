RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        title: "Title",
        description: "MyText",
        completed: false
      ),
      Task.create!(
        title: "Title",
        description: "MyText",
        completed: false
      )
    ])
  end

  it "renders a list of tasks" do
    render

    assert_select "p.font-semibold", text: /Title/, count: 2
    assert_select "span", text: /In Progress/, count: 2
  end
end
