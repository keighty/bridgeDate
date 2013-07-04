require 'spec_helper'

describe "Pages" do
  subject { page }

  shared_examples_for "all pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading) { 'Social Bridge' }
    let(:page_title) { '' }

    it_should_behave_like "all pages"
    it "should have the right links" do
      visit root_path
      click_link "About"
      expect(page).to have_title(full_title('About Us'))
      click_link "Help"
      expect(page).to have_title(full_title('Help'))
    end
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }
    it_should_behave_like "all pages"
    it { should have_title(full_title('Help')) }
  end
end
