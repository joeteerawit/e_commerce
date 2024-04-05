# ECommerce

## start db
```bash
docker run -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgis/postgis
```

## prepare data
use any db client to insert data
- copy sql from `sql/merchant_bank_accounts.sql` then insert it to db
- copy sql from `sql/merchants.sql` then insert it to db
- copy sql from `sql/products.sql` then insert it to db


### run
```bash
mix ecto.create
mix ecto.migrate

iex -S mix phx.server
```