defmodule Solid.Integration.TagsTest do
  use ExUnit.Case, async: true
  import Solid.Helpers

  # test "open tag" do
    # assert render("{% Text", %{ "key" => 123 }) == "{% Text"
  # end

  describe "if" do
    test "true expression" do
      assert render("{% if 1 == 1 %}True{% endif %} is True", %{ "key" => 123 }) == "True is True"
    end

    test "false expression" do
      assert render("{% if 1 != 1 %}True{% endif %}False?", %{ "key" => 123 }) == "False?"
    end

    test "true" do
      assert render("{% if true %}True{% endif %} is True", %{ "key" => 123 }) == "True is True"
    end

    test "false" do
      assert render("{% if false %}True{% endif %}False?", %{ "key" => 123 }) == "False?"
    end

    test "boolean expression" do
      assert render("{% if 1 != 1 or 3 == 3 %}True{% endif %}", %{ "key" => 123 }) == "True"
    end

    test "nested" do
      assert render("{% if 1 == 1 %}{% if 1 != 2 %}True{% endif %}{% endif %} is True", %{ "key" => 123 }) == "True is True"
    end

    test "with object" do
      assert render("{% if 1 != 2 %}{{ key }}{% endif %}", %{ "key" => 123 }) == "123"
    end

    test "else true" do
      assert render("{% if 1 == 1 %}True{% else %}False{% endif %} is True", %{ "key" => 123 }) == "True is True"
    end

    test "else false" do
      assert render("{% if 1 != 1 %}True{% else %}False{% endif %} is False", %{ "key" => 123 }) == "False is False"
    end

    test "elsif" do
      assert render("{% if 1 != 1 %}if{% elsif 1 == 1 %}elsif{% endif %}") == "elsif"
    end
  end

  describe "unless" do
    test "true expression" do
      assert render("{% unless 1 == 1 %}True{% endunless %}False?", %{ "key" => 123 }) == "False?"
    end

    test "false expression" do
      assert render("{% unless 1 != 1 %}True{% endunless %} is True", %{ "key" => 123 }) == "True is True"
    end

    test "true" do
      assert render("{% unless true %}False{% endunless %}False?", %{ "key" => 123 }) == "False?"
    end

    test "false" do
      assert render("{% unless false %}True{% endunless %} is True", %{ "key" => 123 }) == "True is True"
    end

    test "nested" do
      assert render("{% unless 1 != 1 %}{% unless 1 == 2 %}True{% endunless %}{% endunless %} is True", %{ "key" => 123 }) == "True is True"
    end

    test "with object" do
      assert render("{% unless 1 == 2 %}{{ key }}{% endunless %}", %{ "key" => 123 }) == "123"
    end

    test "elsif" do
      assert render("{% unless 1 == 1 %}unless{% elsif 1 == 1 %}elsif{% endunless %}") == "elsif"
    end
  end

  describe "case" do
    test "no matching when" do
      text = """
      {% case handle %}
      {% when 'cake' %}
      This is a cake
      {% endcase %}
      """
      assert render(text) == "\n"
    end

    test "no matching when with else" do
      text = """
      {% case handle %}
      {% when 'cake' %}
      This is a cake
      {% else %}
      Else
      {% endcase %}
      """
      assert render(text) == "\nElse\n\n"
    end

    test "with a matching when" do
      text = """
      {% case handle %}
      {% when 'not_cake' %}
      Not a cake
      {% when 'cake' %}
      This is a cake
      {% endcase %}
      """
      assert render(text, %{ "handle" => "cake"}) == "\nThis is a cake\n\n"
    end
  end
end
