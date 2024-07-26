defmodule ZephyrWeb.ErrorJSONTest do
  use ZephyrWeb.ConnCase, async: true

  test "renders 404" do
    assert ZephyrWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ZephyrWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
