defmodule Explorer.Repo.Celo.Migrations.AddEpochElectionRewardsTable do
  use Ecto.Migration

  def change do
    execute(
      "CREATE TYPE celo_election_reward_type AS ENUM ('voter', 'validator', 'group', 'delegated_payment')",
      "DROP TYPE celo_election_reward_type"
    )

    create table(:celo_epoch_election_rewards, primary_key: false) do
      add(:amount, :numeric, precision: 100, null: false)
      add(:type, :celo_election_reward_type, null: false, primary_key: true)

      add(
        :block_hash,
        references(:blocks, column: :hash, type: :bytea, on_delete: :delete_all),
        null: false,
        primary_key: true
      )

      add(
        :account_hash,
        references(:addresses, column: :hash, on_delete: :delete_all, type: :bytea),
        null: false,
        primary_key: true
      )

      add(
        :associated_account_hash,
        references(:addresses, column: :hash, on_delete: :delete_all, type: :bytea),
        null: false
      )

      timestamps()
    end
  end
end
