defmodule TorngenElixirClient.Test.DynamicSelection do
  use ExUnit.Case, async: false

  @api_key Application.compile_env!(:torngen_elixir_client, :api_key)

  @modules :code.all_available()
           |> Enum.map(&elem(&1, 0))
           |> Enum.map(&to_string/1)
           |> Enum.filter(&String.starts_with?(&1, "Elixir.Torngen.Client.Path."))
           # NOTE: We are unable to test selections with path parameters currently
           |> Enum.filter(fn mod -> mod |> String.split(".") |> length() == 6 end)
           |> Enum.map(&String.to_existing_atom/1)

  for mod <- @modules do
    @tag mod: mod
    @tag resource: elem(mod.path_selection(), 0)
    @tag selection: elem(mod.path_selection(), 1)

    test "selection #{mod.path()}", %{mod: mod} do
      request =
        Req.get!(
          "https://api.torn.com/v2/#{mod.path()}",
          headers: %{
            "Content-Type" => "application/json",
            "Authorization" => "ApiKey #{@api_key}"
          }
        )

      assert floor(request.status / 100) == 2

      request
      |> Map.fetch!(:body)
      |> mod.parse()
    end
  end
end
