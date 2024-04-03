defmodule ECommerce.Helpers do
  def to_map(params), do: Map.from_struct(params) |> Map.delete(:__meta__)
end
