defmodule JobProcessorWeb.DummyControllerTest do
  use JobProcessorWeb.ConnCase

  test "GET /api/job", %{conn: conn} do
    conn = post(conn, "/api/job")
    assert json_response(conn, 200) == %{"message" => "Hello, World!"}
  end
end
