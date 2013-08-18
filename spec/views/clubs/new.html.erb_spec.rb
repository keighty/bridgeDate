require 'spec_helper'

describe "clubs/new" do
  before(:each) do
    assign(:club, stub_model(Club,
      :name => "MyString",
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString"
    ).as_new_record)
  end

  it "renders new club form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", clubs_path, "post" do
      assert_select "input#club_name[name=?]", "club[name]"
      assert_select "input#club_address[name=?]", "club[address]"
      assert_select "input#club_city[name=?]", "club[city]"
      assert_select "input#club_state[name=?]", "club[state]"
      assert_select "input#club_zip[name=?]", "club[zip]"
    end
  end
end
