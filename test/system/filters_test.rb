# test/system/filter_form_test.rb

require "application_system_test_case"

class FiltersTest < ApplicationSystemTestCase
  test "validating company name input" do
    visit root_path

    fill_in "Company Name", with: "Invalid Company Name!@#"
    assert_text "Invalid company name."

    fill_in "Company Name", with: "Valid Company Name"
    refute_text "Invalid company name."
  end

  test "validating industry input" do
    visit root_path

    fill_in "Industry", with: "Invalid Industry!@#"
    assert_text "Invalid company industry."

    fill_in "Industry", with: "Valid Industry"
    refute_text "Invalid company industry."
  end

  test "validating minimum employee count input" do
    visit root_path

    fill_in "Minimum Employee Count", with: "abc"
    assert_text "Invalid employee count."

    fill_in "Minimum Employee Count", with: "100"
    refute_text "Invalid employee count."
  end

  test "validating minimum deal amount input" do
    visit root_path

    fill_in "Minimum Deal Amount", with: "abc"
    assert_text "Invalid deal amount."

    fill_in "Minimum Deal Amount", with: "100.50"
    refute_text "Invalid deal amount."
  end

  test "no companies found alert" do
    visit root_path

    fill_in "Company Name", with: "Inexistent company"
    assert_text "No companies found"
  end
end
