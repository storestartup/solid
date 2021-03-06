defmodule Solid.Integration.FiltersTest do
  use ExUnit.Case, async: true
  import Solid.Helpers

  test "multiple filters" do
    assert render("Text {{ key | default: 1 | upcase }} !", %{ "key" => "abc" }) == "Text ABC !"
  end

  test "upcase filter" do
    assert render("Text {{ key | upcase }} !", %{ "key" => "abc" }) == "Text ABC !"
  end

  test "default filter with default integer" do
    assert render("Number {{ key | default: 456 }} !") == "Number 456 !"
  end

  test "default filter with default string" do
    assert render("Number {{ key | default: \"456\" }} !", %{}) == "Number 456 !"
  end

  test "default filter with default float" do
    assert render("Number {{ key | default: 44.5 }} !", %{}) == "Number 44.5 !"
  end

  test "default filter with nil" do
    assert render("Number {{ nil | default: 456 }} !", %{ "nil" => 123 }) == "Number 456 !"
  end

  test "default filter with an integer" do
    assert render("Number {{ 123 | default: 456 }} !", %{}) == "Number 123 !"
  end

  test "replace" do
    assert render("{{ \"Take my protein pills and put my helmet on\" | replace: \"my\", \"your\" }}", %{})
      == "Take your protein pills and put your helmet on"
  end
end
