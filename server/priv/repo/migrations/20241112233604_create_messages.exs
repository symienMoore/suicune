defmodule Server.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string

      timestamps(type: :utc_datetime)
    end
  end
end
