require "application_system_test_case"

class ExcelsTest < ApplicationSystemTestCase
  setup do
    @excel = excels(:one)
  end

  test "visiting the index" do
    visit excels_url
    assert_selector "h1", text: "Excels"
  end

  test "creating a Excel" do
    visit excels_url
    click_on "New Excel"

    click_on "Create Excel"

    assert_text "Excel was successfully created"
    click_on "Back"
  end

  test "updating a Excel" do
    visit excels_url
    click_on "Edit", match: :first

    click_on "Update Excel"

    assert_text "Excel was successfully updated"
    click_on "Back"
  end

  test "destroying a Excel" do
    visit excels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Excel was successfully destroyed"
  end
end
