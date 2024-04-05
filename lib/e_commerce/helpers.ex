defmodule ECommerce.Helpers do
  def to_map(params), do: convert(params)

  defp convert(data) when is_struct(data), do: data |> Map.from_struct() |> convert()

  defp convert(data) when is_map(data) do
    for {key, value} <- data, reduce: %{} do
      acc ->
        case key do
          :__meta__ ->
            acc

          other ->
            Map.put(acc, other, convert(value))
        end
    end
  end

  defp convert(other), do: other
end
