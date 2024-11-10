defmodule JobProcessorWeb.JobControllerTest do
  use JobProcessorWeb.ConnCase

  test "POST /api/job", %{conn: conn} do
    request_file_path = Path.join(__DIR__, "../../support/example_request.json")
    {:ok, request_content} = File.read(request_file_path)
    {:ok, request_json} = Jason.decode(request_content)

    response_file_path = Path.join(__DIR__, "../../support/example_response.json")
    {:ok, response_content} = File.read(response_file_path)
    {:ok, expected_response_json} = Jason.decode(response_content)

    conn = post(conn, "/api/job", request_json)
    assert json_response(conn, 200) == expected_response_json
  end

  test "POST /api/job_script", %{conn: conn} do
    request_file_path = Path.join(__DIR__, "../../support/example_request.json")
    {:ok, request_content} = File.read(request_file_path)
    {:ok, request_json} = Jason.decode(request_content)

    response_script_file_path = Path.join(__DIR__, "../../support/example_bash_script.sh")
    {:ok, script} = File.read(response_script_file_path)
    expected_response_json = %{"script" => script}

    conn = post(conn, "/api/job_script", request_json)
    assert json_response(conn, 200) == expected_response_json
  end
end
