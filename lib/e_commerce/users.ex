defmodule ECommerce.Users do
  alias ECommerce.Repo
  alias ECommerce.User

  def create(session_id) do
    %User{}
    |> User.changeset(%{session_id: session_id})
    |> Repo.insert()
  end

  def find_by_session_id(session_id) do
    User
    |> Repo.get_by(session_id: session_id)
    |> case do
      nil -> create(session_id)
      user -> {:ok, user}
    end
  end

  def find_by_id(id), do: Repo.get(User, id)
end
