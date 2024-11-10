defmodule JobProcessorWeb.JobControllerTest do
  use JobProcessorWeb.ConnCase

  defp read_json_file(file_path) do
    file_path
    |> File.read!()
    |> Jason.decode!()
  end

  test "POST /api/job", %{conn: conn} do
    request_json = read_json_file(Path.join(__DIR__, "../../support/example_request.json"))
    expected_response_json = read_json_file(Path.join(__DIR__, "../../support/example_response.json"))

    conn = post(conn, "/api/job", request_json)
    assert json_response(conn, 200) == expected_response_json
  end

  test "POST /api/job_script", %{conn: conn} do
    request_json = read_json_file(Path.join(__DIR__, "../../support/example_request.json"))
    script = File.read!(Path.join(__DIR__, "../../support/example_bash_script.sh"))

    expected_response_json = %{"script" => script}

    conn = post(conn, "/api/job_script", request_json)
    assert json_response(conn, 200) == expected_response_json
  end
end
